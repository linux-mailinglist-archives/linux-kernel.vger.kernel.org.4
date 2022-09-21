Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760FB5BF67D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIUGjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIUGjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:39:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E941B9;
        Tue, 20 Sep 2022 23:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97929622AF;
        Wed, 21 Sep 2022 06:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E3EC433D6;
        Wed, 21 Sep 2022 06:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663742368;
        bh=u9IRUQ7jJ5fely4Oj7oSq0iwZF7NJ2Sm7w3sF2MljR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uP3/kH6JmHxy/KpmDkWYQsGbkZnMytSup5w5X55Jm13JFxvN3jfhKxejr3r5o9pON
         rQVDSqQa0exRAgMWL03dkQmqdw6KqdkKGJ1pYnnSBBGRj4lgkOD0jEP0z3XF/x2yvv
         VNixZRrRRlPos7BVla/wn7CrCImfYZ0Jd8p7yVMSszFbkiPEyD/nlnPv1XdB/yTl9E
         fv9T8pWlnxviXUDYPpAPb6HMEZPRFvQ8XjKdKe10xiuBhYbSn36Ucf/UzzPkkBl4RM
         B+QQN7QJxb9LsG/1fJU2zm8VURN78hjcftxSmF7LAiE95WR9IwqcHiSsimpnMCbVQD
         Btc24p51Fq23Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oatOK-0003VO-Df; Wed, 21 Sep 2022 08:39:29 +0200
Date:   Wed, 21 Sep 2022 08:39:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: add dts for sa8540p-ride board
Message-ID: <YyqxoGLUkULxtBM7@hovoldconsulting.com>
References: <20220920120802.14321-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920120802.14321-1-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:37:59PM +0530, Parikshit Pareek wrote:
> This series introduces the Qualcom sa8540p-ride automotive development
> board, also called as Qdrive-3 board.
> 
> Changes in v4:
>  - Removed the ufs_card_hc node, as it is not mounted on Qdrive-3 board.
>  - Removed usb_1 related nodes, as usb1 doesn't have any port connected on
>    Qdrive3 board.

Please include the full change log here (also for earlier versions).

Also, please try to remember to CC people who have commented on earlier
versions of the series when resending.

>  - Added Reported-by tag for Shazad(for ufs and usb_1 node removals)

This is generally not how we use Reported-by tags (even if the kbuild
robot sometimes gets credit for finding things during review this way).

You can give credit to reviewers by for example putting their name in
parentheses after the corresponding changelog entry (or just spelling
out who suggested the change).

> Parikshit Pareek (3):
>   dt-bindings: arm: qcom: Document additional sa8540p device
>   arm64: dts: qcom: sa8295p: move common nodes to dtsi
>   arm64: dts: qcom: introduce sa8540p-ride dts
> 
>  .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 392 +-----------------
>  arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  15 +
>  .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     |   0
>  5 files changed, 31 insertions(+), 378 deletions(-)
>  rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (96%)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
>  copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (100%)

Johan
