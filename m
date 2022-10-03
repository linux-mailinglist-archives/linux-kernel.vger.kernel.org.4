Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0CB5F3773
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJCVGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJCVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:05:45 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B232A19C23
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:05:18 -0700 (PDT)
Received: from [IPV6:2a00:f41:18f3:7ee6:a401:45d0:c41f:c16e] (unknown [IPv6:2a00:f41:18f3:7ee6:a401:45d0:c41f:c16e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 11D0A3F0AB;
        Mon,  3 Oct 2022 23:05:12 +0200 (CEST)
Message-ID: <02365772-de32-56ab-65a2-0a2fbccb5e2e@somainline.org>
Date:   Mon, 3 Oct 2022 23:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH v5 0/3] arm64: dts: qcom: add dts for sa8540p-ride board
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
References: <20221003125444.12975-1-quic_ppareek@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221003125444.12975-1-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/10/2022 14:54, Parikshit Pareek wrote:
> Change in v5:
> - Moved the usb and ufs nodes from sa8540p-adp.dtsi file to respective
>    board specific dts files: sa8295p-adp.dts and sa8540p-adp-ride.dts.

Is there any benefit in this? USB0/2 and UFS (not UFS card) nodes are 
identical

in the 2 files.


Konrad

>    Took inputs from Shazad Hussain in this regard(John)
> - Added more description of the board differences(John)
> - Not including Reviewed-by for Krzysztof, because of the new changes to
>    be reviewed.
> - Removed Reported-by tag(John).
>
> Changes in v4:
>   - Removed the ufs_card_hc node, as it is not mounted on Qdrive-3 board.
>   - Removed usb_1 relared nodes, as usb1 doesn't have any port connected on
>     Qdrive3 board.
>   - Added Reported-by tag for Shazad(for ufs and usb_1 node removals)
>
> Changes in v3:
>   - Added Acked-by tag (Krzysztof)
>   - Renamed dtsi to sa8540p-adp.dtsi (John)
>   - Removed copyright from sa8295-adp.dts and sa8295-adp.dtsi(John)
>   - Added cover letter
>
> change in v2:
> - Make dt-binding patch as the first one in the patch set
> - Add , after year 2022, in the license header
>
> Initial version:
> - Move the common nodes to sa8540p-adp.dtsi, and create qrive-3 board
>    specific file sa8540p-adp-ride.dts.
>
>
> Parikshit Pareek (3):
>    dt-bindings: arm: qcom: Document additional sa8540p device
>    arm64: dts: qcom: sa8295p: move common nodes to dtsi
>    arm64: dts: qcom: introduce sa8540p-ride dts
>
>   .../devicetree/bindings/arm/qcom.yaml         |   1 +
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 528 +++++-------------
>   arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  71 +++
>   .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     | 133 -----
>   5 files changed, 219 insertions(+), 515 deletions(-)
>   rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (70%)
>   create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
>   copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (72%)
>
