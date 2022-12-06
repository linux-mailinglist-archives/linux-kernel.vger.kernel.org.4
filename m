Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413156442E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiLFMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiLFMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:05:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84DAB7CB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:03:49 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 57C2B44232
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670328228;
        bh=brtPlso4v+WsnAGgbWLqD0qaP/DWC2mCOIzkN3hJ/jA=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
         Content-Type:MIME-Version;
        b=gfZi6hA7kxEOKRuBEQgII6fQOfkxNKe+KGk7A9zvTR9SFcwzLOf0czIZ5C4LF5JFS
         tFzz2BSBSy96sQIuQewedKUQtLkBnE90zdUwOAESXU+sMycbjp1IAKzUPWT4yOe4tg
         plZu9TjmQ1d5BBZoglnSM9nwwgVs6fwwFz67QpTUjeDuuUvSr2G2e3bxA7i8QSmxHQ
         KTXeYU1LESxMeVqw+RmkUIOK9wz2fgdzxSfvrv5yeEiEM4epGJc3c9IgvLVLwXO9MX
         kJJHc/YOOBGlyBBMggvi6zpgiclwZQ1tAhgD1CpdPDnHx3T03d2KmY3jar48NKAs5A
         gSVb3gWsUeHNA==
Received: by mail-ed1-f70.google.com with SMTP id w22-20020a056402269600b0046b00a9ee5fso7704604edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 04:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brtPlso4v+WsnAGgbWLqD0qaP/DWC2mCOIzkN3hJ/jA=;
        b=x0mSXnbuTjOPkyhMtcp7tyVgdsu7jPcfYdnZ55qVuczaFJE9mlXSEO3jrAOwWe2sO9
         i5Oa5wxokyLMeOWWCj5y+OgztVFQMVz5k/YFCfdNcVAexkwlW8Z8Rk0rLHCXZBoHTJBU
         dB96714IjU9VKXf5XdJIQ0mF3yY9WkJsTOn/kKAadM5fUiGpVkbjvx4FEUKkQf2/c19O
         wXGWNwo0pnl0I/FEBaw+MDQjB5MWLBLHF2BtqE5LydDYA7h0KNSfYGihSdMAsXpatLob
         uU6fFt+fZg4+8DbbrcqIkxXUGxlthTQa8tU6Rq9ns5LIBQELfx5SNjpP5Ao5xCoAJvk5
         pc7Q==
X-Gm-Message-State: ANoB5pmdqWyI5waveWofTVRV2SnRSY/2CvbG/RP6YCrZzcVuhGhPmeon
        ZJ4ByvqGJp6CxQo+VvgNcmU1eQucuiWE5bNpvT+A203fftIVlgs2JnPhIaW4Sf8lTK1m50Tpep1
        AHesCfUNEG3J2ZP/YVjrnPrPlln+aOHGT0RGP5TIhLw==
X-Received: by 2002:a17:906:1310:b0:7c0:c5e9:634d with SMTP id w16-20020a170906131000b007c0c5e9634dmr15321585ejb.220.1670328227917;
        Tue, 06 Dec 2022 04:03:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53XzYQZ9m1URY2w6jlEHp7rS5tCFGriu9rXA6LSOHfWrCMGtPfHrgs+qnXI07YhR2WvnFdNg==
X-Received: by 2002:a17:906:1310:b0:7c0:c5e9:634d with SMTP id w16-20020a170906131000b007c0c5e9634dmr15321567ejb.220.1670328227650;
        Tue, 06 Dec 2022 04:03:47 -0800 (PST)
Received: from [192.168.1.27] ([92.44.145.54])
        by smtp.gmail.com with ESMTPSA id gg9-20020a170906e28900b007c0d41736c0sm4138501ejb.39.2022.12.06.04.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 04:03:47 -0800 (PST)
Message-ID: <a22e2c8de905d7f9d3cf3525269487a6b5da4bf5.camel@canonical.com>
Subject: Re: Regarding 711f8c3fb3db "Bluetooth: L2CAP: Fix accepting
 connection request for invalid SPSM"
From:   Cengiz Can <cengiz.can@canonical.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 06 Dec 2022 15:03:34 +0300
In-Reply-To: <Y48sR0xv0yuH8GDd@kroah.com>
References: <f0b260c1-a7c4-9e0e-5b29-a3c8a7570df1@canonical.com>
         <Y48sR0xv0yuH8GDd@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-06 at 12:49 +0100, Greg KH wrote:
>=20
> I've already done this backport and it is in the latest -rc1 stable
> kernel releases.  Is it not working for you there?  Why do it again?

Sorry for the noise. I was just trying to make sure that I'm following
the right path.

I know that 4.4.y is no longer actively maintained but I was trying to
backport it to there as well.

Sorry for the noise again.

Cengiz Can

