Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56CD66680B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjALAoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbjALAoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:44:16 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA701C6;
        Wed, 11 Jan 2023 16:44:15 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id d188so3001588oia.3;
        Wed, 11 Jan 2023 16:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIv3be1lRIXRPQ1LjI3kjHosQpUlUitVVwaVG1prwbw=;
        b=JcOmGy7E9H2w8wTb6q8fo6RJTJ60t/femaw139P1Va6XfCIKNwehUDGhlKhrFp3vOE
         hr+1Zc1l0GW4j0v9hETbyyZiDZb88UIz3RL+Y8LygY8DiL6UFCrvwXsCPBTvqd4vvbpH
         5ktRhpXFmAAuKrCp0JyzeftPixCkEjgFphvwoEcEsswt3cPsVMagR3hy8xgZgXzd4LLo
         I4TUhGlN5YSdASG1j6aLi0d6Hbac5oIdOzXOnOSoxJL7T8V0gKlKjsEMB0OcX9IHqxiT
         mv2rc/1/9ICJ3StR83IsofV/KIa6q9NQ1u4R+vKGBBQow7EpvVuncgeoxjHOKyBizgsi
         5sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIv3be1lRIXRPQ1LjI3kjHosQpUlUitVVwaVG1prwbw=;
        b=2Dt0fk+Ki7Ylg5d6xSII1kP7lHusCORfkfOV3g1sb9jxRVsbE9ZB5k4z0ncFCOq/DK
         EqXRxtr8pLntsuBp0MlvVNhaYgrhsX+J5GIqnrejp8vwYQoGJV0jLwZ1D3f8zGb5LdKA
         zYdrpuB0vmraeZNx7zZHfK7XvLTvqnzxhJD0YqavFQf7jZ1cqBT8SRPW8gC5McrpXW4F
         8KGBSbTkMUE91ssG/+6gU1bGShLxYLYiwb699zdlUdUjaJgtv/AWLv5ISLRVTp1a2Iaq
         NmSeFbW4mHJqE7RZkR8MK2EaR6MGMoZGqixu/bGfrpGpGuumT4ib8Pdt7QODCP8T0U5R
         nNig==
X-Gm-Message-State: AFqh2kp5vD5U6NPKCT/kAuUfnuTHBTtc7Jw4RJDtAwsXzTZycl8oRjd3
        lyd9vNtYWFrTGsnlNsiNeyo=
X-Google-Smtp-Source: AMrXdXshLnj8CJ12c+R9mC312SX7Hmu6gEq4rM9ET9S8swUVEgcQJPexsniRAWdHkbum4iGHU1Frhw==
X-Received: by 2002:a05:6808:607:b0:360:e96a:8748 with SMTP id y7-20020a056808060700b00360e96a8748mr30656284oih.15.1673484254668;
        Wed, 11 Jan 2023 16:44:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dp6-20020a056808424600b003458d346a60sm7298479oib.25.2023.01.11.16.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 16:44:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Jan 2023 16:44:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jon Cormier <jcormier@criticallink.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Dan Vincelette <dvincelette@criticallink.com>
Subject: Re: [PATCH v3 3/5] hwmon: ltc2945: Handle error case in
 ltc2945_value_store
Message-ID: <20230112004413.GD1991532@roeck-us.net>
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com>
 <20230109233534.1932370-4-jcormier@criticallink.com>
 <d49d4b4c-e7ee-e0a1-56e6-7f193e0d1340@roeck-us.net>
 <CADL8D3YEkZaOjUY3mRLGT0M+b7MwN5zQZrbsw5W8Mn=PJ7PtcA@mail.gmail.com>
 <dd80ee77-3b71-ee47-2744-36b09e0ec372@roeck-us.net>
 <CADL8D3YksXnRkEgXkY86KZXM4nouJBemno=db5KgbCi3xmSa8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADL8D3YksXnRkEgXkY86KZXM4nouJBemno=db5KgbCi3xmSa8Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:25:37PM -0500, Jon Cormier wrote:
> On Tue, Jan 10, 2023 at 1:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 1/10/23 10:19, Jon Cormier wrote:
> > > On Mon, Jan 9, 2023 at 7:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> On 1/9/23 15:35, Jonathan Cormier wrote:
> > >>> ltc2945_val_to_reg errors were not being handled
> > >>> which would have resulted in register being set to
> > >>> 0 (clamped) instead of being left alone.
> > >>>
> > >>> Change reg_to_val and val_to_reg to return values
> > >>> via parameters to make it more obvious when an
> > >>> error case isn't handled. Also to allow
> > >>> the regval type to be the correct sign in prep for
> > >>> next commits.
> > >>>
> > >>
> > >> Sorry, I don't see that as reason or argument for such invasive changes.
> > >> As far as I can see, a two-liner to check the return value of val_to_reg()
> > >> should have been sufficient. Most of the rest, such as splitting
> > >> the return value into two elements, is POV and just adds additional code
> > >> and complexity for zero gain.
> > > I can do that. However, you had also mentioned changing the return
> > > type to match what the calling function was expecting, an unsigned
> > > long. But I can't do that since error codes are negative so it would
> > > be a signed long which would lose precision and seemingly defeat the
> > > point of matching the variable type the caller wants.  I could make it
> > > a signed long long but that still doesn't match.  So it seemed saner
> > > to just return the error and the value separately, that way the
> > > function declaration was explicit about the types it wanted/returned,
> > > and less room for error.  Would love to know your preferred solution.
> > >
> >
> > That is only true if the upper bit is actually ever set in that signed long.
> > Which means I'll have to verify if "would lose precision" is actually
> > a correct statement.
> I'd like to argue that is another reason to go with this change
> instead of working out the math of just how many bits are needed in
> the worst case and having to document it. And potentially getting that
> calculation wrong.  But I can if you'd like me to.

You are turning things on its head. We don't make changes like that
because of maybe. It is you who has to show that the change is
necessary, and that there is indeed a loss of precision otherwise.

Guenter
