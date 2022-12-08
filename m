Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE8647799
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLHU7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLHU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:59:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9887726FC;
        Thu,  8 Dec 2022 12:59:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n21so6870515ejb.9;
        Thu, 08 Dec 2022 12:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2uWthW/PoKfC02t1PaCjD6R5HbN1AuXQTJXkZCHE+YY=;
        b=MmnxtYapb1tWKOt5UnNiQ50t6JfjSaObmvZa9LHlnCnsyJLPhgzfbg0O+ARqNk1b2T
         Iibz2OIB+1N9V+0Ptw1fa+ywzBwARGYBCNCLZOyGv3BEba2lXVw+SgGgL8Qz3twBv+uO
         5inxZ7C3lgG64UliXO9ETDOP1UzM4HzoCGeMR3Bb7XbrIJYLuaymbfIFcdl3+uuWddAD
         dnBDfQ6CcbGyc2Wo9j5Aib2LW5kIDOCsDGbadJga9MRYFgJfUWX0LFNeg+J6LqlmsSg0
         oKmSSBKI5aBbm/tHxZlPGCVNcJeGVUEuq+cpoRdczZnCXGHlKoT/mIw5Q+emTMhHjgCD
         SUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uWthW/PoKfC02t1PaCjD6R5HbN1AuXQTJXkZCHE+YY=;
        b=Ua+B6R4KP9TrudNGzHTdYUqUy2j3UhHuJyXRfdKfBNnJKhc8gxhKWcecx4u6+Zg+rK
         7KP5vjL7jXwYrmOKpl89F5959zbjfV0deMoCSW//44YCB/G2RtUGLF1svurrH/+tAVH1
         YYF+KOar4t7ZsOLMJeitJyHpec+vVYCGrSClqq7dJWmMVTo+C7jP+mUOJZStJRCJzGCX
         8AJlxsGNq5vr8hbJMrtFZKIn6LBZhQTtdQglqjhT0Sl9CCCYC9ZMDuzHE8meGDvZgFmh
         Hobmq7DIOufrenDCNDn1KrvyAOCWzodM6LHsVRQrXZjJzy7B+cGwYQYYmzO8mB8CI9hj
         Q3Zg==
X-Gm-Message-State: ANoB5plRa5vthy94yoMV0slCGXCI6gUWveuAJSWepgK5VNwFoShEKKk8
        V909OoF3xI68CTCD/LOGN+ZKVCdKq8gwc4EbjdQ=
X-Google-Smtp-Source: AA0mqf4TZbKeyFx4CKL8mJSNkg1i0m8ENpo9jfVK5zMkFq9D/i/Tbc9xNhHkPb/J8xrS0UtiJUz5Ipmfcj/xQEyAwC0=
X-Received: by 2002:a17:906:a083:b0:7b2:b15e:322f with SMTP id
 q3-20020a170906a08300b007b2b15e322fmr76404842ejy.75.1670533144943; Thu, 08
 Dec 2022 12:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20221205210354.11846-1-andrew.smirnov@gmail.com> <CADyDSO4uh6b+sSZTkZ2_DR923=bA=kXgK1LqUMkknCMzf_DSwQ@mail.gmail.com>
In-Reply-To: <CADyDSO4uh6b+sSZTkZ2_DR923=bA=kXgK1LqUMkknCMzf_DSwQ@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 8 Dec 2022 12:58:53 -0800
Message-ID: <CAHQ1cqGaL5v4PARTZU6_0tfSCz3=9b1THz-D-Bg1G64hBV+_Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Handling of non-numbered feature reports by hidraw
To:     David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 7:46 AM David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hi
>
> On Mon, 5 Dec 2022 at 22:04, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> > I'm working on a firmware of a device that exposes a HID interface via
> > USB and/or BLE and uses, among other things, non-numbered feature
> > reports. Included in this series are two paches I had to create in
> > order for hidraw devices created for aforementioned subsystems to
> > behave in the same way when exerciesd by the same test tool.
> >
> > I don't know if the patches are acceptable as-is WRT to not breaking
> > existing userspace, hence the RFC tag.
>
> Can you elaborate why you remove the special handling from USBHID but
> add it to UHID? They both operate logically on the same level, so
> shouldn't we simply adjust uhid to include the report-id in buf[0]?
>
> Also, you override buf[0] in UHID, so I wonder what UHID currently
> returns there?
>
> IOW, can you elaborate a bit what the current behavior of each of the
> involved modules is, and what behavior you would expect? This would
> allow to better understand what you are trying to achieve. The more
> context you can give, the easier it is to understand what happens
> there.
>

Sorry it's not very clear, so the difference between the cases is that
in the case of UHID the report ID ends up being included as a part of
"SET_FEATURE", so BlueZ checks UHID_DEV_NUMBERED_FEATURE_REPORTS,
which is not set (correctly) and tries to send the whole payload. This
ends up as a maxlen + 1 (extra byte) write to a property that is
maxlen long, which gets rejected by device's BLE stack.

In the case of USBHID the problem happens in "GET_FEATURE" path. When
userspace reads the expected data back it gets an extra 0 prepended to
the payload, so all of the actual payload has an offset of 1. This
doesn't happen with UHID, which I think is the correct behavior here.

Hopefully that explains the difference, let me know if something is unclear
