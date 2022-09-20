Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD545BEFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiITWHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiITWGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:06:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D57823A;
        Tue, 20 Sep 2022 15:06:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z20so4786147ljq.3;
        Tue, 20 Sep 2022 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a9ubx309RX1ylp0ri8FQHRE+Ot7n/V281h2L8ls5In4=;
        b=f6MmcYOwAYsrIA5CL3o7P41f5aLRTH3qjADB1yb7j69cDZOf4IplgaPTFMVeO7Mj0/
         nmM3sO706SHqBIEA/JUwXaQGg3GAlG4vtk0glFNDNKPIJdtYw2IXRyGTcCtes0wV5rIJ
         E/+0HYA5dq9kFbprP6wMtKk4+v1HOybv3VCipl0Yt9F83jVgv96qhPRqS+lWK0zTa+W7
         p9hUpKLdG5tl+4y3UGVa3wsZxOtZdSvUpF+VOZX4WdJwNkbIf96oHl7C6EGGTIsaYV+p
         d6R2uUI5JyT+tPjhyvIZiKQHZXydSo8kH8IZpYZ4RlMTl2vCMiufIo5ZVZqRILO/FTQm
         bnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a9ubx309RX1ylp0ri8FQHRE+Ot7n/V281h2L8ls5In4=;
        b=nAaMZZ8tb3KMwaEVvvpq204QMEdN7ieCqvgc8DQbYFrUycFUnAvkqXUMHNPsaZbmJq
         c5TW5+qSroBYvC9GK2+mEFM4h0kbXUjPrd4thx0FVInsvHZiTVBp3LU//wUZ95ztpRIM
         Tlp2w/S6Qwy0bqYfKLh5T4fh6y3s1S8tWQMHMQ+FIWU2W0lzsFUfF5ywOidFdmB91fsZ
         uQ+ylf3YJssE+LWO11A/r6LSv+Z79SC8Yk3UloT7XJTl3sbyaF3Q0cQ77fooLD3evgg5
         SR8C5T3sFecucalHhpOEBmq8HGnH+8LDGgdi9Tr5pyaRcxfZADN3lOqvSG0zcW9ecDdG
         bMNA==
X-Gm-Message-State: ACrzQf1F7moYNk3JoH1kGcYY1DVQLUYmxnT4oux+BQqcpXAkqJgvBvTt
        LPKuKsn8wuIPUaaZkNMdeOeZerbTlioEWk1/Oxo=
X-Google-Smtp-Source: AMsMyM5nNjVOgPsvg2ltOp9vieGuvpDwGmMcdiUn6iYkd7ldmbVk28u3g6FNg1y4TX2uolan/VR7Er8RnJz6ZzMZzco=
X-Received: by 2002:a2e:828d:0:b0:26b:e531:c64d with SMTP id
 y13-20020a2e828d000000b0026be531c64dmr8023960ljg.355.1663711599391; Tue, 20
 Sep 2022 15:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <RINjeKS0brZzIa6F-fgBKuiHrrcZB8zfTg_chbQIT3BRLqx-l9SmsxvV3LXx7upuctFCki33uAIhXNsM92YWTub8vbzSQHcJibhPkN5ijB8=@protonmail.com>
 <CAEVj2tn8byGn2RHmvYc77rv2BZkApW3yQ5qSDDzNGxhbygO2Ag@mail.gmail.com>
In-Reply-To: <CAEVj2tn8byGn2RHmvYc77rv2BZkApW3yQ5qSDDzNGxhbygO2Ag@mail.gmail.com>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Tue, 20 Sep 2022 18:06:27 -0400
Message-ID: <CAEVj2t=F-zF9jTmfJuqx=DRFopygKDXVv0wX91nRLqP1QZqS_w@mail.gmail.com>
Subject: Re: [PATCH v2] HID: nintendo: check analog user calibration for plausibility
To:     Johnothan King <johnothanking@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
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

>  static const u16 DFLT_STICK_CAL_CEN = 2000;
>  static const u16 DFLT_STICK_CAL_MAX = 3500;
>  static const u16 DFLT_STICK_CAL_MIN = 500;
> +static void joycon_use_default_calibration(struct joycon_ctlr *ctlr,
> +                                          struct joycon_stick_cal *cal_x,
> +                                          struct joycon_stick_cal *cal_y,
> +                                          const char *stick, int ret)
> +{
> +       hid_warn(ctlr->hdev,
> +                "Failed to read %s stick cal, "
> +                "using defaults; e=%d\n",
> +                stick, ret);
> +

Sorry, missed this on my first readthrough. I think the coding style
mentions not to break up the logged string into multiple lines, since
it'll harm greppability.

-Daniel
