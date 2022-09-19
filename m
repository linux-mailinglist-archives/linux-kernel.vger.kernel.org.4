Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA05BC191
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiISC5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiISC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:57:18 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8C4165B5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:57:16 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220919025714epoutp02fe94640a83f7f400757bb32e2df5b919~WI5TpAiYf2744027440epoutp02J
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:57:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220919025714epoutp02fe94640a83f7f400757bb32e2df5b919~WI5TpAiYf2744027440epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663556234;
        bh=084LBby79OsODlIZWeJtplq16tew4amO/mu6CCGXogk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=MV4gvVqbUU7L9KNapdR/yGLzom1uY/A7UfkQTgucVqUy5OF2jR5qJFa5rzeLc/8XY
         3k8qN5QV4jrAmnNkOWYbWbFne4V4+LdZB5e/xFv6HFtBjpv4zElcXuA1QJ1zPqaRBT
         yMFxzm3ZRPx/9SuhRaSF+PjmSdvSwcR0+nBIIUKs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220919025714epcas1p440b40f302c3c3dbf0daf0b28ac7cdec6~WI5TGa6wW0730607306epcas1p4X;
        Mon, 19 Sep 2022 02:57:14 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MW8V11h2Mz4x9Py; Mon, 19 Sep
        2022 02:57:13 +0000 (GMT)
X-AuditID: b6c32a38-0cdff70000021e0b-5d-6327da89d0a2
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.7F.07691.98AD7236; Mon, 19 Sep 2022 11:57:13 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v2 01/13] trinity: Add base driver
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Jiho Chu <jiho.chu@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yelin Jeong <yelini.jeong@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220919110040.80b06ab4aa7460ad02c3246e@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220919025712epcms1p14191bcd1e53c354fd797414d6c27b0eb@epcms1p1>
Date:   Mon, 19 Sep 2022 11:57:12 +0900
X-CMS-MailID: 20220919025712epcms1p14191bcd1e53c354fd797414d6c27b0eb
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTX7fzlnqyQcdGDou/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i309Hxktnk+7zuLA4fH71yRGj02rOtk87lzbw+axf+4a
        do++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAE6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFqgV5yYW1yal66X
        l1piZWhgYGQKVJiQnXF483v2giucFfNe9DA2ML5g72Lk5JAQMJGYNmcHG4gtJLCDUWL5Lssu
        Rg4OXgFBib87hEHCwgJWEuu6j7BAlChJNNzcxwwR15foeLCNEcRmE9CV2LrhLliNiICnxOaV
        nUDjuTiYBVYzSUyeMZMZYhevxIz2pywQtrTE9uVbwZo5BZwkVhz+CBUXlbi5+i07jP3+2HxG
        CFtEovXeWag5ghIPfu5mBLkTZM7PK/oguyQEJjNKnDxxnBHCmcMoMW3DOzaIBn2JM3NPgtm8
        Ar4SF2a8YAKxWQRUJS7++Ae12EXiYPcTsDizgLzE9rdzmEEWMAtoSqzfpQ8R5pN497WHFeaX
        HfMgyiUE1CQO7V4CdbOMxOnpC6Hu9JBYfvUQC8g9QgJdTBLTt5xjncAoPwsRvrOQbJuFsG0B
        I/MqRrHUguLc9NRiwwITeIwm5+duYgQnSC2LHYxz337QO8TIxMF4iFGCg1lJhFfVUyVZiDcl
        sbIqtSg/vqg0J7X4EKMp0J8TmaVEk/OBKTqvJN7QxNLAxMzI2MTC0MxQSZxXT5sxWUggPbEk
        NTs1tSC1CKaPiYNTqoGJWyVxjdWllpjjh3i/JyUsCdgZq7yH79C3JY82Sq0qX8j3a+Y0//dv
        WqumO79YuifLev0FQ7viir3xYhX2r5/+PxS1ZuOCxwJ3pJ7m/4m8kr7YoNt1F9viXKkHJT6q
        j0KCTky9e6HqznnjxYIpBtWPEgID3/6uW1je8Wnb+q+bzUJSeW20Fa9GbZrt8FX1rkkNr1lR
        d9/n4jP7Ncsl2Ex+qPz5s1AiskTqkXBV+VeGqNfT355onXZnl4Tmg68LtFid47Ry/jXdDTji
        F3Hz4pP0VUt5TXKX5iTJZ1vGHbt+NzW/ZOmGtNmHNDR5H+976HQwnmdW35bHX27u36L6WLq1
        93Ke393Pn57xq228V3XvpBJLcUaioRZzUXEiAEeGCBwZBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p17b277154f0d020435417450fa0337906
References: <20220919110040.80b06ab4aa7460ad02c3246e@samsung.com>
        <20220917072356.2255620-1-jiho.chu@samsung.com>
        <20220917072356.2255620-2-jiho.chu@samsung.com> <Yyb0a96poEWZUe1y@kroah.com>
        <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcms1p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 18 Sep 2022 12:35:23 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Sep 17, 2022 at 04:23:44PM +0900, Jiho Chu wrote:
> > > It contains the base codes for trinity driver. Minimal codes to load and
> > > probe device is provided. The Trinity Family is controlled by the
> > > Memory-Mapped Registers, the register addresses and offsets are
> > > described. And user api interfaces are presented to control device under
> > > ioctl manner.
> > 
> > Where is the documentation for how the userspace api works?  And where
> > is a link to the userspace code that talks to these devices?  That
> > belongs here in this commit changelog text please.
> > 
> 
> Hi, Greg
> Thanks for your review.
> 
> The user space library is published in:
> https://review.tizen.org/gerrit/gitweb?p=platform/adaptation/npu/trix-engine.git;a=summary
> 
> It needs to login to tizen, access guide is:
> https://docs.tizen.org/platform/get-started/open-source-project/
> 
> And, this information will be included in commit log.

The URL without log-in is more appropriate.

Please use https://git.tizen.org/cgit/platform/adaptation/npu/trix-engine/
instead of review.tizen.org.

Cheers,
MyungJoo

