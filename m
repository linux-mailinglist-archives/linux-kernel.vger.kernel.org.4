Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5A6AB62A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 06:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCFF5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 00:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFF5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 00:57:37 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873191C5BE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 21:57:35 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h9so8446655ljq.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 21:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678082253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p57OV1cWt0LQcfOeYUDqj5S3ULJnVt+I3s3PkFnB7L4=;
        b=ILy5d1EF72Pkvm/BfFsati4g0tFI99CMyerI/EtpSpdD7SrOVTBOmlmfpmZlV6wyjz
         5JTgKllXmpRVAe2ccpAxeDsofWftcfRODTWPqtAxkJB0aEjCn34jWvNmL8DXwqj2viT2
         F2UHk9uzeNi1zKKTHzTybLur/uyzaRuGkcW0WJOuoMV2n3fG3N3Qqm9gPgT21ULdUpIe
         dnNTSSPzWvCialZnf++ecJKc8Dsh5VAJQAMtewGBVOfpolSq23yt2UgO0XLCa8lJnzjW
         yhDZ4wdKOmiK/25ia3CT+VQuY05PK9ucETWhIzCqs7AE1L9OBBdVFF0XMx+gXUtoyWRG
         RT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678082253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p57OV1cWt0LQcfOeYUDqj5S3ULJnVt+I3s3PkFnB7L4=;
        b=dNyvb86c2NGx11lQGT/xhsD1SvU3F6kzPXNdDF+PBHqMQTfcoXq8lCVzfh917dw6tS
         MWQ10BIUG2iPVvm7vtIIefNeP/o95yZyXi//xPziizPpx1g7Y7YmU/j+DgafsYo+D7uS
         2z2GJm6iTjqbXM+7JFRaWrnE4Ag5fC/qCdIs6JFDoOZWTRPzPExXQbh4dFKT4vnVDEGo
         iis4QuS7odRXY6zPO5B8YFvwfwkAwZIWmy0gnF6ivVDIBdi0X65qjZoKC0r88wGDivuT
         Z4qJFdODkIOXu1BxCJ4MYCbIbjOZC4Tz+MrgIcKgs7VUYoLBoG98f2kuqAF3vN9YfYy2
         7B9g==
X-Gm-Message-State: AO0yUKUwrCHy7gK7w0Y5cyPK/wlpB52j+F+fchVW9RP3uW7FeqWM5p/d
        cSPACf1DhBSyopqyuRGe0GU=
X-Google-Smtp-Source: AK7set+YKh/bpIzYvSADwWCplOVqVDziAp2shTuQF58MRsdPSkI0CqBDys+jYzbIXE4VsBAEpEcDOg==
X-Received: by 2002:a2e:3304:0:b0:294:6ee3:eaaf with SMTP id d4-20020a2e3304000000b002946ee3eaafmr2503600ljc.28.1678082253620;
        Sun, 05 Mar 2023 21:57:33 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00295b9d903b7sm1545109ljo.119.2023.03.05.21.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 21:57:33 -0800 (PST)
Date:   Mon, 6 Mar 2023 06:57:31 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <ZAWAyyNt0rgrpA1l@combine-ThinkPad-S1-Yoga>
References: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
 <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
 <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
 <Y+DL3O5lcMyZ/aNR@kroah.com>
 <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
 <Y+IJgxF52lpgk0RC@ubun2204.myguest.virtualbox.org>
 <ZAVxo6WHGu3kO1nl@combine-ThinkPad-S1-Yoga>
 <ZAV7xvr3BCqByjy6@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAV7xvr3BCqByjy6@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:06:06AM +0530, Deepak R Varma wrote:
> On Mon, Mar 06, 2023 at 05:52:51AM +0100, Guru Mehar Rachaputi wrote:
> > On Tue, Feb 07, 2023 at 01:49:15PM +0530, Deepak R Varma wrote:
> > 
> > Hej Deepak,
> > 
> > I have a problem in sending patchset through mutt.
> > I have been trying sending to my own mail address but it won't work.
> 
> This could be because of mutt configuration. There are some additional checks if
> you are trying to use mutt with gmail. Search over google or lore old posts to
> know more about it. The important aspect is to configure and test mutt well
> before you use it for sending out patches.
> 
> > 
> > When sending patchset I think we should use "In-Reply-To" flag and
> > include "Message-ID" to which we want this to be in series to. I tried
> > both "git send-email" feature and mutt "forwarding feature".
> 
> I have not used "git send-email", so can't help you there. But mutt has worked
> very well for me. Ensure you are reading and following the instructions from
> this page well: https://kernelnewbies.org/Outreachyfirstpatch
>

So for example from these patches: 0.patch, 1.patch
how to use "mutt -H" to send patches in one thread?

if first one is: mutt -H 0.patch
then should second one be: mutt -H 1.patch In-Reply-To: Message-ID?


> > 
> > Another issue is, how to attach patch file from inside mutt(for example: 
> > "mutt -H x.patch" from command line is used to extract header and body of a 
> > mail in mutt)?
> 
> Why do you want to do that?
> Build a patch file using "git format-patch" and then use "mutt -H" to send the
> patch. Both the commands work directly from the command line. If there is a need 
> for any additional attachments in support of your patch [configs, logs, trace as
> evidence, test outcomes etc], you can attach those from within the "mutt -H"
> execution context.
> 
> I suggest testing mutt well before you start sending any patches out by sending
> the patches to yourself. Do not use any kernel mailing list for testing.
> 
> 
> Regards,
> Deepak.
> 
> > 
> > 
> > -- 
> > Thanks & Regards,
> > Guru
> > 
> 
> 

-- 
Thanks & Regards,
Guru
