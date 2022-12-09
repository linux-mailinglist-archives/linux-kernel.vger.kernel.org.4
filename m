Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A326F648130
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLIK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLIK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:56:59 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FB13A2D3;
        Fri,  9 Dec 2022 02:56:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 817355C0166;
        Fri,  9 Dec 2022 05:56:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 09 Dec 2022 05:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1670583417; x=1670669817; bh=w1
        otl967u68MCBaOx0vm7u3myDK0ku2dIZUUldypgTc=; b=EDqduu2g4J9kHwUTOm
        HUYvFTP/kNckyKbZDN17tGDkFbKUCactcbBjj0urUno+j5qtxR1DUAv9iOsdky81
        yiJYZdWuy8LO3IYEfyEM9+bD3mat6Gyk2ugx7DnNvgM0MrKvC5YHoWlLkcCdmJ1Z
        2Io44JVU7knnFvhXoNB9DIkAWtDlhzw2h8rfSGtRB9FTBja8y3VZuG/pDPSw1O3a
        qi2P2ViLe1ha+WeJWtXMMviETJgTzciTF4R8IP3I4NJGF995CGRVP8NalHL6CiDS
        fQLvK9A8GRFMEyFqxXn6a9OnbinMVUouAMwfcAT8wDLuddkqbZEJnTW2A7izscc8
        WRcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1670583417; x=1670669817; bh=w1otl967u68MC
        BaOx0vm7u3myDK0ku2dIZUUldypgTc=; b=Oynndpa9pBgOJDn03WPWbz67HDr7r
        NBH4HgtJV6X2Qna2havV8zbTtloQH2bUAXJhMSl1kMMG5wk8gLokCDIBNd7rYR/D
        qLEem/1QuPN1IBmdhLJf3G3jiwH7zdzGSUxKM/O2huZ28KIVbU9MpKkxoodwZpwY
        Nl3uEkYYrGKcoMIbSFMzzLbpC0hdRB+C3oJYOMoqfP7dzuoCBNTvYKNBQ5ILF+UW
        5tiVuuF41WJciM1mpb+BFKWHLv89nWBHOO2Qo84ejtOBRdZuGapgXjUPRxH/J49L
        X2VNcEaHz0H1YVlCQu69Du+jA7HxmJkpF2cfj/nFvoc5Pm4DX8FgPEK3A==
X-ME-Sender: <xms:eBSTY-HzDkqUiBsliq1RjPs56jITtxNISzasTYwdFfqT365ZUgZ-fQ>
    <xme:eBSTY_UY3DA1DI3y93hsqKq6j91_xPUNtan0QZgFnBXDYR8L1NPZsnM9sfv473ajA
    r2_1IitUvFt24QBfDk>
X-ME-Received: <xmr:eBSTY4IWX_t1UQiz-7vBLYBZgAGdy1RJ8ziFfIWTuOd_SxFjK7tWj3amXUwdtIizaJ7pMAQXr2MivTeDkvvLJMs6r7e9UYzbxueQrlS-ZoorlV6e9tR_Etta4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflrghrrhgr
    hhcuifhoshgsvghllhcuoehkvghrnhgvlhesuhhnuggvfhdrthhoohhlsheqnecuggftrf
    grthhtvghrnhepveejveefudehteegtedvveeutefgfeefleffuefhgfejvefgfefhkeef
    jefhvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhgvrhhnvghlsehunhguvghfrdhtohholhhs
X-ME-Proxy: <xmx:eBSTY4HNcDaih9SIKj8aLwmctCFCLT5TfoivoOeAhDnmUfuZ9JAZgw>
    <xmx:eBSTY0Uq2RMFOwJviEhVInfyAQpWaVJGoZ44hxkk0tNXSNLt4L0Qsw>
    <xmx:eBSTY7OZ890kWAPYVTIhaO_N0UnTpP8dBQ0edGNrtLsQ6c_J1Gp7wA>
    <xmx:eRSTY4qj6LvWWu1HGucItYq6-Hp93WPcFQMFMRQHesln_g7WouRJ6A>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Dec 2022 05:56:53 -0500 (EST)
From:   Jarrah Gosbell <kernel@undef.tools>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Jarrah Gosbell <kernel@undef.tools>
Subject: [PATCH 2/2] dt-bindings: sound: rt5640: Allow to describe how LOUT is wired
Date:   Fri,  9 Dec 2022 10:56:21 +0000
Message-Id: <20221209105621.39237-2-kernel@undef.tools>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221209105621.39237-1-kernel@undef.tools>
References: <20221209105621.39237-1-kernel@undef.tools>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

Depending on HW design, som boards may expect mono differential output
on LOUT. Describe a property that enables it.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
---
 Documentation/devicetree/bindings/sound/rt5640.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index ff1228713f7e..0c398581d52b 100644
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -20,6 +20,9 @@ Optional properties:
 - realtek,in3-differential
   Boolean. Indicate MIC1/2/3 input are differential, rather than single-ended.
 
+- realtek,lout-differential
+  Boolean. Indicate LOUT output is differential, rather than stereo.
+
 - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
 
 - realtek,dmic1-data-pin
-- 
2.35.1

