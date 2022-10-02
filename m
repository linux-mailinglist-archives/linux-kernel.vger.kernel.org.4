Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1815F2367
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiJBNi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJBNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:38:53 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35427156;
        Sun,  2 Oct 2022 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VPfLIxTyDxs11YmrlrvCyBbBU0ckJgv+7bpPq3+FUSA=; b=GU0NHmCwBS0axqF/wGvZ41F+zP
        MD3WB5iBKDxxmvggCMjKQsAB2dcCzwQ3BM6x38gEay9e8OS4Ed8FxBsbnEv2c8N3ZOc97q2LICCiy
        LD1XHF24Ujj0Zl3o4cstsb55Dll+Kxy+mSTdfZE0lqt9f5bqh/D+KNCG9I6lDc1W2Os5Ndm8P5oAV
        JPQzoQyfEfYTIyggcCIXzsabenLN6QZUItWVYh1ITbxIjTlx3y6q/e4imHqwEiDBxKmUgmgx7AXWH
        zmeAcgHUNPDh21+c/7PWyQa8QI3FtPLna0yyXUoDklZJsNHVSxHiDW+fcm1KvygWXB8Ypx1ySRqQ8
        9AEG7pZQ==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:56422 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oezBD-002vfu-Eo;
        Sun, 02 Oct 2022 09:38:51 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sm6125: Use qcom,arm-v2 for MMU
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20221001185750.495874-1-martin.botka@somainline.org>
Date:   Sun, 2 Oct 2022 09:38:47 -0400
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C0BFFC6-74C1-49B8-AD7B-5BE8D32D3660@sladewatkins.net>
References: <20221001185750.495874-1-martin.botka@somainline.org>
To:     Martin Botka <martin.botka@somainline.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - premium237.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sladewatkins.net
X-Get-Message-Sender-Via: premium237.web-hosting.com: authenticated_id: srw@sladewatkins.net
X-Authenticated-Sender: premium237.web-hosting.com: srw@sladewatkins.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Oct 1, 2022, at 2:57 PM, Martin Botka <martin.botka@somainline.org> =
wrote:
>=20
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---

What does this patch address? There=E2=80=99s no commit message here.

-srw

