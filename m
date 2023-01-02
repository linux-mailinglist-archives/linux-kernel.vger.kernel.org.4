Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE565B139
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjABLcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjABLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:31:40 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE7387
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:31:38 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230102113135epoutp03853b757cab166faf11470216bb13022a~2epXdhg4q0780807808epoutp03G
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 11:31:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230102113135epoutp03853b757cab166faf11470216bb13022a~2epXdhg4q0780807808epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672659095;
        bh=vT6IxLs7Z6EoLjlbQBcs1ppskfmHauknzyfEWkrF1nw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=M1SgV+cBx9GPrEexhGaWS5FWb0K247unpvte5XvjbHdMcNtzOnN0o357TuF9XBRPL
         M0QD8yDZ86kfhiLy6dOmnJ7lHqSbLjzmdHgKOJhR3+FMBgziJi4tu1Ies8vJnTOZSz
         UMidXdhBPyKqSEebjjIfVQBE6bdE9T5UqIm+xRfs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230102113135epcas5p2021ed52ccc2430684e166914186a4acf~2epW-Bh8m0099400994epcas5p2w;
        Mon,  2 Jan 2023 11:31:35 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nltx14HmDz4x9Pt; Mon,  2 Jan
        2023 11:31:33 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.DF.02301.590C2B36; Mon,  2 Jan 2023 20:31:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230102093538epcas5p2e311441e00f4ec7f53c2ef9f7cdf8b90~2dEIJO53B3083430834epcas5p2C;
        Mon,  2 Jan 2023 09:35:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230102093538epsmtrp14c3c50bfeb512ff9c21622eca586e9f8~2dEIIjpL-0685506855epsmtrp1f;
        Mon,  2 Jan 2023 09:35:38 +0000 (GMT)
X-AuditID: b6c32a49-201ff700000108fd-74-63b2c0950310
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.B1.02211.A65A2B36; Mon,  2 Jan 2023 18:35:38 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230102093537epsmtip2090604e18d0f3f19f79779de85f4c508~2dEG6kS7l0481504815epsmtip2O;
        Mon,  2 Jan 2023 09:35:37 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alim.akhtar@samsung.com>, <s.prashar@samsung.com>,
        <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <af5a7b65-9917-58d2-315e-71e902826a54@linaro.org>
Subject: RE: [PATCH] arm64: dts: fsd: fix PUD values as per FSD HW UM
Date:   Mon, 2 Jan 2023 15:05:35 +0530
Message-ID: <020601d91e8d$92954b60$b7bfe220$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK5YmDUytel1KIanVI5IVzdrffbcwLW7lD+Auv+maysnD5vkA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmlu7UA5uSDXb8UbB4MG8bm8X8I+dY
        LfpePGS22Pt6K7vF5V1z2CwWbf3CbtG69wi7xbwdcxkdODw2repk87hzbQ+bR9+WVYwenzfJ
        BbBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2h
        pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUq
        TMjOmLL5G2vBAY6KjVN2MDYwdrB3MXJySAiYSLSe6mHrYuTiEBLYzShxbu4fJpCEkMAnRonf
        qxQhEt8YJe6cPQPXsWXLbhaIxF6gjq9bmCGcF0AdO88wglSxCZhLLNq7FMwWETjLKPF+oWwX
        IwcHs4CDxP17VSBhTgE7iVXX9oOVCAu4SrSfuwpmswioSByae4IVxOYVsJT41TuLCcIWlDg5
        8wkLiM0sIC+x/e0cZoiDFCR+Pl3GCrHKSaLn8DNGiBpxiaM/e8BukxCYyCEx9/JjFogGF4mm
        9l9QzcISr45vgfpMSuJlfxuUnS8x7WMzG4RdIdH2cQMThG0vceDKHBaIXzQl1u/ShwjLSkw9
        tY4JYi+fRO/vJ1DlvBI75sHYqhLrl29ihLClJfZd38s4gVFpFpLXZiF5bRaSF2YhbFvAyLKK
        UTK1oDg3PbXYtMAwL7UcHt/J+bmbGMGJVMtzB+PdBx/0DjEycTAeYpTgYFYS4b38eV2yEG9K
        YmVValF+fFFpTmrxIUZTYHhPZJYSTc4HpvK8knhDE0sDEzMzMxNLYzNDJXHe1K3zk4UE0hNL
        UrNTUwtSi2D6mDg4pRqY9OxMeyTmTl7dkG1h9uK0erRaR/W6l+wtZz9OXjLVyMjWMeDdOj7z
        X9xPyx3bn6m+NrPgCyq+8sL70AuGLTHyluyP2PkL3n17JtIhfktDYuG/FocGBWvebylV8esX
        3GY9dCDuZs2+L1IdHJGsHw3WHarY9/jtUyPrf5dPZ399GzX77ifdh4uYClu39fefltq4e1/K
        xym7v3cFftTpkwq4V/Szb1H85q2SSY8Pdk0/LyZxP+SZ0bx6DbWjP9/kbe1cxHrqL//0C7zK
        u35HJR5vLp3gH1/DYSObO3ch/wqP7wvfPBNmUPmalpjec+GbXk6cTsGW2uX+O9XOCJ7l/qFp
        KLSMedviDLf/ftKzbq2qV2Ipzkg01GIuKk4EADKcZ3stBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXjdr6aZkg2cHZSwezNvGZjH/yDlW
        i74XD5kt9r7eym5xedccNotFW7+wW7TuPcJuMW/HXEYHDo9NqzrZPO5c28Pm0bdlFaPH501y
        ASxRXDYpqTmZZalF+nYJXBlTNn9jLTjAUbFxyg7GBsYO9i5GTg4JAROJLVt2s3QxcnEICexm
        lDi2aw0rREJaYnr/HjYIW1hi5b/n7BBFzxglXr08DdbNJmAusWjvUkaQhIjARUaJhe/vs4Ak
        mAWcJCYu2QA19gCjREPXNrAEp4CdxKpr+xlBbGEBV4n2c1fBbBYBFYlDc0+AreYVsJT41TuL
        CcIWlDg58wnUUG2J3oetjBC2vMT2t3OYIc5TkPj5dBlYrwjQ4p7Dz6BqxCWO/uxhnsAoPAvJ
        qFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCY0pLcwfj9lUf
        9A4xMnEwHmKU4GBWEuG9/HldshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNT
        UwtSi2CyTBycUg1MZxl+SxVNvle7IvJTreh33elcUdtcSjeXfZ6ywmDH/6znrZ0BZl6B9+f3
        tx+5cuX7vJ3tRSYhmRE/0qdbRTBEJVyUfVd6It5NqXDH92bzuwcSuUS+75u496w+9+ejW3R/
        z7j4Uk7poNOi+r9F/JX+/w0n//jKcUPy08U7phwmD+9ucGmVTnz4SkaycemrfSKv/93Nv84Q
        G+b5JbGj0iPI8dKnjqxVM+o/lOyz3ad+znpmbbDGJr0r7u9vNAXpiiqdT5oc5WIya+tyl3c6
        zVxzjLVWMaxTkFFordUTS8kTk/jCXJhQUSFz3KCPaUpli3rQ56+frvLPjmn60OL16qG0kXdX
        7OS/nWfyu09u/6msxFKckWioxVxUnAgAer9/kRgDAAA=
X-CMS-MailID: 20230102093538epcas5p2e311441e00f4ec7f53c2ef9f7cdf8b90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129095529epcas5p31acfecd374b59cddd2e67d2efcdd86b4
References: <CGME20221129095529epcas5p31acfecd374b59cddd2e67d2efcdd86b4@epcas5p3.samsung.com>
        <20221129095516.89132-1-p.rajanbabu@samsung.com>
        <af5a7b65-9917-58d2-315e-71e902826a54@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: 26 December 2022 08:41 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> alim.akhtar@samsung.com; s.prashar@samsung.com;
> pankaj.dubey@samsung.com
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] arm64: dts: fsd: fix PUD values as per FSD HW UM
> 
> On 29/11/2022 10:55, Padmanabhan Rajanbabu wrote:
> > PUD values used for UFS, SPI and UART are not reflecting the default
> > values recommended by FSD HW UM. Therefore, changing the same to
> > comply with HW UM recommendation.
> >
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 +++++++-------
> 
> This patch does not apply, please rebase on my for-next or linux-next (once
> released).

Okay, I've rebased on your for-next branch and posted the v2 patch.

> 
> Best regards,
> Krzysztof

Thanks,
Padmanabhan R.

