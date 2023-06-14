Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85EE72F5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbjFNHRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbjFNHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:28 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5EE268A;
        Wed, 14 Jun 2023 00:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726977; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bEzKwn+50P4YOlrikEkWfuMJZQuy3ndxlaD2MNzus/io7TZDZKTcU2Oh0LEGh4zaBz
    SRwLwfTVYsS6DZmWPkVf5cEQsIietKXEdAekuMiM23TIft85bt2QB8HOs2J5ejApV3Dl
    rwnY6zLUF4ixxFSh2ony7SLk0+zUVANG6c+eDS1NrUxId5uJJEgNs+UxHNvQH416okzW
    JnxS9FtWqdndWjBlCvdKHBTHXuIduHgjtLo7rap5gQ0vNscu7W9VzwLaoK0H2H/ZoD4p
    3EZMDcr+HMRwC1WIeyxHTMeM/0IyWVE2i1AATLxShHqIzI+FvEE390jZQ8EpZdHb0Rsq
    Eurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=r7SgX1cnPFHFFUF629tLWSor9gaXRJcL/juQUpleFE8=;
    b=J0p+SwgOqKmEwyqBY8KrFOfLHtYspdF8yPwN2skhs+DO/tuXopvKdi0pH47TIPqJmI
    TOr5QnM1R1kOOw8EiN6I6xiWUB3qWeV+2QiAKkv//kaQIJ7pNMAlO0goRhtSj7ik3ToM
    NSDaTXGRXswl1ThYEY+9Qc/+s65lZaBy5K86t/6JdfMg18vtucq9xHHos+r3hJ3Uh+IS
    45pH2Pqt1NtShoVPfhNuO36kdPpoqo3jtChXPlmVHLGkEefOXk1oVat1rA98zNII/znE
    +zYIC320ZzTRkj1DtrOKjfrxhm0elsfDwKm2bdY1RUzZw78oWPHmaE+4VveQJYLZ0bJM
    lcOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=r7SgX1cnPFHFFUF629tLWSor9gaXRJcL/juQUpleFE8=;
    b=ltpgPgSpQ4CJjhgYU8s+9v2xyEWoHKi4yW087gqKIzFL2ff0Cms+1Ez8tPs7ctvSaT
    xY/ytFnrB0QeixYtkm5wFD85tza477mZv0kG+ci4yniunm8CUOLtYP4bHLKAdvaTEUSk
    mNBPyFdQ8IMKMnKiX4n1++vHwCohoDWsUQHyuDtWLgEhb0jkgWZQSJ+uNvgptT2yACbj
    YWaI1NAU1ylWhpjkt0TN56LK7NbqiQthMQG3RBKSMpfj+/meG/bH/kwy4nANpzpKhyxk
    ayI5hBJB6M42d7HG8UrxlZHm+FAODQ3OHoUdX2FLPZQNNCZu0yBBPh8S6+PxkRfkVvfu
    rNFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=r7SgX1cnPFHFFUF629tLWSor9gaXRJcL/juQUpleFE8=;
    b=V90qruhHNYzykL64jqlbBmawzvi66XRStgfYG5k7DtdFvc0L19iTXIpH8NNSsKGOam
    k1etbs1K0ocEXkFRWaBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GHb2d
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:17 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:16:00 +0200
Subject: [PATCH 2/8] arm64: dts: qcom: msm8939: Disable lpass_codec by
 default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-2-a3c3ac833567@gerhold.net>
References: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
In-Reply-To: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update for recent changes to msm8916.dtsi in commit a5cf21b14666
("arm64: dts: qcom: msm8916: Disable audio codecs by default") and
make lpass_codec disabled by default for devices that are not using
the audio codec functionality inside MSM8939.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8039-t2.dts | 4 ++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 2a39216ceef5..c8442242137a 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -135,6 +135,10 @@ &lpass {
 	status = "okay";
 };
 
+&lpass_codec {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 3c1505b69a6b..895cafc11480 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1608,6 +1608,7 @@ lpass_codec: audio-codec@771c000 {
 				 <&gcc GCC_CODEC_DIGCODEC_CLK>;
 			clock-names = "ahbix-clk", "mclk";
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		sdhc_1: mmc@7824900 {

-- 
2.40.1

