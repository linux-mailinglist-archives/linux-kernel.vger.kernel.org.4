Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6B6E152E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDMT26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:28:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5186A2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:28:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bs70so7945778pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1681414135; x=1684006135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/owY4mvJye7p0v+ne1bcGdPR7zZGvCD2rKYaG4godE=;
        b=Ke4xzhCwH3sUAprbBW59xNAypk0Fk1toJ1iQKBdNYbUFTS5XDMc1gET/Fg0DoMsB/V
         jqPxWPYgVVI9P2Ga9B5cpUdNM3SXTm22pU3dRBoA5cDHytQbWzbB018KOWQprE7vL2PA
         Fs8G7iqv0ojRtUrKzOlvMw1df3CTZmFAh394vpsVvh6NKZLSSeMrniQbNkEDbPF5NHwm
         cQIy1+r5n5mOP7U+xqFxiKyk/6jxJqo5mqtOKuQSVj0wUIYft5WbaepZIe2iYZRcudAo
         tUu3Usejx5dQkgXut8J3kAc2938Fi8DFig2DZmSkeEg1OcSLRjOrE9hCwenjFB9RrWlm
         cTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414135; x=1684006135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/owY4mvJye7p0v+ne1bcGdPR7zZGvCD2rKYaG4godE=;
        b=MnQCA3F3Azs08MI+opztqo8hCpSDHGxHtLwKh9YwOSthpOcYF9+cjPMRyL3HvjrvVZ
         hyd2GhZAIITOaYnxqyIdbikiEbr3A010vGIF3kNk9mNRWwVOuo/mfpdTJU2kUDOrBN0v
         7hwz6wsufIkOFMYHieNYugeSU4XqjDZcf2UkHpEsMA/o2SimgvBLXMKsI4yimiKAq/qL
         4OE4mkmIzqdr7Gy3Hb9r5Aie01dvk1lYNBXiJEHNoxFss03XXtlD18MsNgYB2O/GbXVy
         /vaJbqtvKnjGjgzjxHOki/0MkIjxB2tmWJRdhdTGgxE/vqiHOaHYFZHmrulKPQSN9o8E
         zL6g==
X-Gm-Message-State: AAQBX9dkPnyztp6rVKnH9GsRDyOpsSdgrit4YyZ6OgjxlKzpQaM0qLq5
        oFzEcjM90gwOvp5rvD76VP9m+clCunow300CoNTWTg==
X-Google-Smtp-Source: AKy350ZvcynFOTI0vNXbHNNrkwfyvIqzDj+xMZMJFaPDZ1bx+dUQLOfRxKAyDO2ht4EiFV67iIZltiL6dHISQ0dim9s=
X-Received: by 2002:a65:6289:0:b0:513:a24c:f45a with SMTP id
 f9-20020a656289000000b00513a24cf45amr25095pgv.11.1681414135164; Thu, 13 Apr
 2023 12:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230413085206.149730-1-iivanov@suse.de> <20230413085206.149730-3-iivanov@suse.de>
 <9b03551a-278d-16dc-08ed-1ef0f89dc79c@i2se.com> <duuhz5pju4q7lnvzwndcnruqwqzbwy4jhrfn42vov2rfct4i7c@qh55cifhoud7>
 <9de62851-73a6-0070-4e64-94b6614c11fd@i2se.com>
In-Reply-To: <9de62851-73a6-0070-4e64-94b6614c11fd@i2se.com>
From:   Tim Gover <tim.gover@raspberrypi.com>
Date:   Thu, 13 Apr 2023 20:28:43 +0100
Message-ID: <CAAvKZ64KyXJ2QPjRnj3i-8AKh7jGCUw=HNi76XG-a9K-+_JiYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: Add nvmem node for BCM2711 bootloader
 public key
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 19:44, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Ivan,
>
> Am 13.04.23 um 20:18 schrieb Ivan T. Ivanov:
> > On 04-13 18:15, Stefan Wahren wrote:
> >>
> >> Hi Ivan,
> >>
> >> Am 13.04.23 um 10:52 schrieb Ivan T. Ivanov:
> >>> From: Tim Gover <tim.gover@raspberrypi.com>
> >>>
> >>> Make a copy of the bootloader secure-boot public key available to the OS
> >>> via an nvmem node. The placement information is populated by the
> >>> Raspberry Pi firmware if a public key is present in the BCM2711
> >>> bootloader EEPROM.
> >>
> >> It would be nice to have a helpful link like:
> >> https://www.raspberrypi.com/documentation/computers/configuration.html#nvmem-nodes
> >
> > Yep, make sense.
> >
> >>> +
> >>> +   /*
> >>> +    * RPi4 will copy the binary public key blob (if present) from the bootloader
> >>> +    * into memory for use by the OS.
> >>> +    */
> >>> +   blpubkey: nvram@1 {
> >>> +           compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";
> >>
> >> Yes this looks better, but this introduce a new dtbs_check issue. The new
> >
> > Oops, yes, I forgot to make this check.
> >
> >> compatible must be documented in
> >> Documentation/devicetree/bindings/nvmem/rmem.yaml in a separate patch and
> >> reviewed by the DT guys.
> >
> > Or I can drop the new compatible string altogether? It looks like
> > only alias is strictly required?! Tim Gover is this correct?
>
> i cannot speak for the firmware side, but i think we should try to keep
> it compatible with the vendor DTB here.
>

The firmware doesn't look at the compatible string. It locates the
nodes to update using the 'blconfig' and 'blpubkey' aliases. Userspace
scripts (including the documentation example) should also use these
aliases.
Therefore, I don't think it matters if the compatible strings is
modified, but I won't pretend to know what the correct DT style is
here :)

Tim
