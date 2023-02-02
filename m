Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEA687994
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBBJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjBBJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:56:26 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E53875A3;
        Thu,  2 Feb 2023 01:56:21 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s17so954718ois.10;
        Thu, 02 Feb 2023 01:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqJ2bM4RcFWC3YKdPNwQw4CDw5pRiYrlonhKnhKfnIc=;
        b=aktC30zudvFIQmtB4Sp1gTrMEUtsdB0E3tSPY6naP/DC7quRfmd7Ew35iIteA9wB5b
         pbyFSDr4r6xb19AGw9J3XpWhUyaXz6gRCmURCVBXcvekGOE72qxBSIO/LDlXpm6cALCx
         9P3IYXsFxO45WD+/e35TE5Z5MlIyE0HZoq5/FnPmVIwpnDH6UFPJTg/W4GPmwxO/m71B
         E4KcxfPCaQd9Ioft4HBXwKXSsdbvqn46pZbMIpBX8o8gpP/ibpDeCRI9I01KoKiz5icg
         v6USUS9EX10GTfK+VriL8U8CnKL/QPu6DxLyWzMd9Hxz8aD5GMQQOG52U+eVknH0mhiD
         yFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqJ2bM4RcFWC3YKdPNwQw4CDw5pRiYrlonhKnhKfnIc=;
        b=qFwHwQwqIWUbnVFIY8UhzXk4AqOHOg/whawQXfOWenEFZbdOSc8Aez2yGZhLoqc0pU
         9OM48xQ1kP0n3kXKuGwpkRB6KBskAl+BJIr5MYLwEKzVhOC01B15Zt6eMcgNvLVLwqp0
         PzlmYQixC4uX1u01jk5zins5f1Q++AdohI2APKZvL+TStWI27iIKq3F8UpJViSHNKmZt
         nixePQBOiEIjAhrXQm7BUCsvyHJCRxh+50HbA6qHNyTaVMATjAwshpfNSjRN6xtPCx1j
         jZKrjmVd9Yl6/xpj3EGJ4sgd6k1V2Xyq6tPm+Xy6XDQoGiAapJpaD+8SHHG+lZHXJ1F2
         eHfA==
X-Gm-Message-State: AO0yUKXvd+2m4Bc82P7EDex/m3WYxJYwCASGPWi0q54O/tsaOFazB6Tq
        n4NRyTwUyjasdeQIWXzkA2csnz3Wf+Sm3ZpGVsrAEjPa1hI=
X-Google-Smtp-Source: AK7set/Po9300JuBC+F7tVJoBWPD5tPQ7+3/0skSjAA8iqlz5r8mcAU1qUhOxd+FgKOJmHp33d7UdN8n5NFy/WGW6GM=
X-Received: by 2002:a05:6808:60e:b0:37a:c636:6af3 with SMTP id
 y14-20020a056808060e00b0037ac6366af3mr93436oih.77.1675331780263; Thu, 02 Feb
 2023 01:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20230109123216.4974-1-fengqi706@gmail.com> <nycvar.YFH.7.76.2301201849090.1734@cbobk.fhfr.pm>
 <CACOZ=ZWB3grJKn7wAZEZ0BDyN7KJF4VWUTNs-mPxeoW_oiR7=g@mail.gmail.com> <nycvar.YFH.7.76.2301301527100.1734@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2301301527100.1734@cbobk.fhfr.pm>
From:   qi feng <fengqi706@gmail.com>
Date:   Thu, 2 Feb 2023 17:56:10 +0800
Message-ID: <CACOZ=ZVd+kreyctS7TjUkcoMm+Kni=jjFi5oN0GTr6JK4MTkMw@mail.gmail.com>
Subject: Re: [PATCH] HID: add KEY_CAMERA_FOCUS event in HID
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I resubmitted V2 according to the standard, please help me to review it

thanks a lot

Jiri Kosina <jikos@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=B8=80 22:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 29 Jan 2023, qi feng wrote:
>
> > Hi,
> > Our Bluetooth Handle needs the focus function, which is missing in the
> > current map
> > If our setting is unreasonable, do you have other suggested values
>
> If the device is under your control, wouldn't it be better to let it
> produce something more defined by HID standard? (see e.g. 0x90 -- Camera
> Control Page).
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
