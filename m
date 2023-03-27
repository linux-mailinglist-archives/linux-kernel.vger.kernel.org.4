Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232F46CA2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjC0LoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjC0LoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:44:08 -0400
X-Greylist: delayed 1115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 04:44:07 PDT
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C558269F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:44:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=YG00kI5R7ljzmjLZhxIbq1sI32aj8EKJ0r+P1J4vQE4QDP4FPQdrF/sQz4ZeYQbt3LiTpmzBA7S5GduF5D1S//XP34o/Z85Eti2faEK66lSPhAcNoRluunTOHT7INFrdb9pFgAdXtdBQuN7PfyFR0gf/Kd3oYKDCk+KIMYqajf+EpItGNaJgIZuGTU7qFaH3atekTnt5EpHBYIU8cx/V2BNB/QXRkgrSgBWDLeI2v7Rs0m4ZZIydl9UmqD/Oobqdh3gSFLNjlVGUYeE5lPZTx0BzM4ANmJnj2CMh18S7ZCSr4pF+cez7wioQazyY/V9XKOeUg2xesmWEeTr4QvfvFg==; s=purelymail1; d=iskren.info; v=1; bh=q1q6QlROVAEEz2iajcRh0+Y4NPypwdDdDX9tz1qlxrQ=; h=Received:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=BHREr0xixlDoBzbB0XwPbYSLJSqj31FKvWCCSa32GrMZrtrvSZHOxPR7XItW5NJZ7d1v/Y3Pp30hyoAkN5sVbTA+0r3v6i7Z/f13ueS1P3Gy0NMCTqu99A0DN/+T8gDLFA9sD0n5FtohTfKn59kocYftIgaUb86W2Rc4XYs4ulwPmiDFHdvsVW8kMOr1mPW/nr3W2uaYZcUZui9deIt+tIjPGXyYu6KV70veRvHeoNnCAUQUyBW4W2AXd5sCCcUpy9qwaxToEQw0HRTzr8AEo5esfXA9uenCJYSnIVWtmhHVmYmH9Xm1+FVkM9H339osDAzoeAwYPtmto8qPLT17fg==; s=purelymail1; d=purelymail.com; v=1; bh=q1q6QlROVAEEz2iajcRh0+Y4NPypwdDdDX9tz1qlxrQ=; h=Feedback-ID:Received:Subject:To:From;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1765702763;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 27 Mar 2023 11:24:40 +0000 (UTC)
Message-ID: <edfa2aac-b341-f827-5e7d-88248fa22309@iskren.info>
Date:   Mon, 27 Mar 2023 14:24:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/3] Fix some issues in QCOM UFS bindings
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
Content-Language: en-US
From:   Iskren Chernev <me@iskren.info>
In-Reply-To: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 09:41, Luca Weiss wrote:
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Iskren Chernev <me@iskren.info>

(for the series)

> ---
> Changes in v3:
> - Drop applied patch
> - Pick up sm6115 patch from v5 https://lore.kernel.org/all/20221030094258.486428-2-iskren.chernev@gmail.com/
> - Rebase on linux-next
> - Link to v2: https://lore.kernel.org/r/20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com
> 
> Changes in v2:
> - Add new patch adding reg-names to sm6115 & rebase series on top of sm6115
>   addition
> - Fix binding example after sm8450 move, split this patch from original patch
>   since it became too big
> - Move reg-names definition to top-level
> - Link to v1: https://lore.kernel.org/r/20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com
> 
> ---
> Iskren Chernev (1):
>       dt-bindings: ufs: qcom: Add sm6115 binding
> 
> Luca Weiss (2):
>       dt-bindings: ufs: qcom: Add reg-names property for ICE
>       dt-bindings: ufs: qcom: Fix sm8450 bindings
> 
>  .../devicetree/bindings/ufs/qcom,ufs.yaml          | 61 ++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 5 deletions(-)
> ---
> base-commit: e5dbf24e8b9e6aa0a185d86ce46a7a9c79ebb40f
> change-id: 20221209-dt-binding-ufs-2d7f64797ff2
> 
> Best regards,
