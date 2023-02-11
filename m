Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387576933B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBKUoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:44:05 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD8815569;
        Sat, 11 Feb 2023 12:44:02 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jg8so23477303ejc.6;
        Sat, 11 Feb 2023 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8zOtPlzHJyHxTzcrkWdaVbHH64HwzLCruk6URO7DX8=;
        b=IxGtg6nk24e1PphBTr7tAA4k7Gzm7NpJH7BPGixZQjYkpp2AIPbZQLy78S6jSBPggW
         VC+Nl4mc5RUv4ZR0zCeJcA27MjbtiKVv8fNbcaLDrwttWssNYdnIUNgrDjOn1l/slN8E
         v5a6FURwBcW5GkOIk4upbVRIZE1hChJfzRyYzg2RYfjWKf9Xc1wMo7UcVcQkvRsk+5Sx
         w5MbTVv/x5HgOZ/e8FuurF2wr+vS9rT//xnagN9L8r0Kc3Y6L/zuTyx6ReG+P3JXbFcQ
         joWC3dIJvjRjlZQ5pHXCVSKaN/AyFUom++QNOhs4UrUvP0Sc7x7beGCS4oHNdDnxL9Kv
         3Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8zOtPlzHJyHxTzcrkWdaVbHH64HwzLCruk6URO7DX8=;
        b=LIfR71i/aazikH78Lux4idOwBAoF4q+h9XHYjh9FSHZ3g5g4WdT3BC3pt4uO64NmtW
         Ya1qWYfJPww7LnQlF2U5niLlB+hmYG6kpxnICVy5anBSVfbhnmd/FDQtKkXbhgtskTwC
         SwnKK27yTH1WznhaVAuJcOSw69ZE8a++CGQbWR4CmeI2r9981mTapmWdKSbhmqtBnz4I
         xHBMqeuOsGGjgd8Npi02o2JpoTrMoaD0mxzxzkeX+kFpnqGi8rkSMGVZUd2OXmx8D22A
         3P3jcbw12uF0ACOsEDzurMiXBXrOXRAhc9HBSm2HsGdMjaHCJ37k2gTkiFPUv0VupXnu
         2L/Q==
X-Gm-Message-State: AO0yUKUoQO1Ql4VGEKiV8m4eqgxNfbb1NWPyv0SYIuY0AA+61QgwT5WG
        iFZ84XSRVcDfmosLVQsOF9altU+pySlQjcQhuCE=
X-Google-Smtp-Source: AK7set8Yu6t24lt4jzLsbMqeVxPWjxq7UB4zuraEzhHwkMfIvWsjOz/rR+qfggrbvg0BVZyEoM5EDMV541EyrpqAESA=
X-Received: by 2002:a17:906:25d3:b0:878:6f5d:cecf with SMTP id
 n19-20020a17090625d300b008786f5dcecfmr2788745ejb.4.1676148241489; Sat, 11 Feb
 2023 12:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20230109223110.1165433-1-martin.blumenstingl@googlemail.com> <Y+DPQjukgC0BELkN@intel.com>
In-Reply-To: <Y+DPQjukgC0BELkN@intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:43:50 +0100
Message-ID: <CAFBinCBpbRu9xfCEfZJfT7t3doV=+CX03+h7W+HsoW5T4X0W0w@mail.gmail.com>
Subject: Re: [PATCH v1 RFC] video/hdmi: Fix HDMI_VENDOR_INFOFRAME_SIZE
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ville.

On Mon, Feb 6, 2023 at 10:58 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
[...]
> > Change HDMI_VENDOR_INFOFRAME_SIZE to 6 bytes so
> > hdmi_vendor_infoframe_pack_only() can properly check the passed buffer
> > size and avoid an out of bounds write to ptr[8] or ptr[9].
>
> The function should return -ENOSPC if the caller didn't
> provide a big enough buffer.
Indeed, I'm not sure why I didn't notice when I sent the patch.

> Are you saying there are drivers that are passing a bogus size here?
Thankfully not - at least when I checked the last time drivers passed
a 10 byte - or bigger - buffer.
My main concern is the HDMI_INFOFRAME_SIZE macro. It's used in various
drivers like this:
  u8 buffer[HDMI_INFOFRAME_SIZE(AVI)];

One could use HDMI_VENDOR_INFOFRAME_SIZE with this as well:
  u8 buffer[HDMI_INFOFRAME_SIZE(VENDOR)];
But it would only result in an 8 byte wide buffer.
Nobody uses it like this yet.

Do you see any reason why my patch could cause problems?
If not then I want to re-send it with an updated description.


Best regards,
Martin
