Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C762C33A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiKPP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiKPP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:58:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F15B5F70;
        Wed, 16 Nov 2022 07:58:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C916AB81DDE;
        Wed, 16 Nov 2022 15:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61694C433D6;
        Wed, 16 Nov 2022 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668614309;
        bh=v5GcVpco2YLS3UOar/6+Y/vprzGBgz2LJlb22kjusiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEIiRkgR83HlnvuV8sgJO60s8Lcw5NrYVUlWrWKAqExRLVGb9GO6YkrAjHsOVNtnn
         ip7pXssD5DmZTujPsLCCh8Y/liMiVqFjNBiGP5v2USFY67ZdB6at/U4kzWzLjTaogk
         WRmzoMG2uhXakyEoAUXItG8pl4PR5wI+QWDwAQ/tHQL2OxDmoBT2u0CJiyaLIFSx7f
         kDUmkOkcO0pDaigoR8LUk7INif9NyDgP5EIMcircjgbudgIDFbqkfadBoZqFAsatKb
         T94H6n4x5dDjJGcJCc1xQt6JahHvjfBcVtUqPtQ3I8+a5TA4uRL1t+wsc/GXHjC/B2
         5ijFyapQhub9A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovKnX-0004A8-5t; Wed, 16 Nov 2022 16:57:59 +0100
Date:   Wed, 16 Nov 2022 16:57:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v9 0/2] arm64: dts: qcom: add dts for sa8540p-ride board
Message-ID: <Y3UIh8e+KrWxfT/B@hovoldconsulting.com>
References: <20221116154932.17127-1-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116154932.17127-1-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 09:19:30PM +0530, Parikshit Pareek wrote:
> Changes in v9:
>  - Enabled ufs_mem_hc/ufs_mem_phy nodes(John)

My name is Johan (below as well).

>  - Corrected the indentation of 'regulator-allowed-modes' properties.

> 
> Changes in v8:
>  - Changed the schema of the regulators(Krzysztof)
>  - Removed node remoteproc_adsp(Andrew)
>  - Removed TODO comment for node usb_0_dwc3(Andrew)
>  - Added Reviewed-by/Tested-by(Eric)
> 
> Changes in v7:
>  - Put the smpi bus related pmic changes in sseparate dtsi files(Konrad)
>  - Mention allowed regulator modes via DT property regulator-allowed-modes
>    (Konrad and Brian)
>  - Remove unused ldo nodes vreg_l3c and vreg_l10c(Shazad)
> 
> Changes in v6:
>  - Introduced the new dts for the board, rather than moving common nodes
>    between this one and SA8295 ADP board into dtsi file(Bjorn)
>  - Drop 'adp' term to imply it being unrelated with ADP board(Internal
>    discussion with Bjorn)
>  - Removed Acked-by(Krzysztof) tag in dt-binding document, due to content
>    change.
>  - Not including Reviewed-by(Krzysztof), because of the content change.
> 
> Changes in v5:
>  - Moved the usb and ufs nodes from sa8540p-adp.dtsi file to respective
>    board specific dts files: sa8295p-adp.dts and sa8540p-adp-ride.dts.
>    Took inputs from Shazad Hussain in this regard(John)
>  - Added more description of the board differences(John)
>  - Not including Reviewed-by for Krzysztof, because of the new changes to
>    be reviewed.
>  - Removed Reported-by tag(John).
> 
> Changes in v4:
> - Removed the ufs_card_hc node, as it is not mounted on Qdrive-3 board.
> - Removed usb_1 relared nodes, as usb1 doesn't have any port connected
>    on Qdrive3 board.
> - Added Reported-by tag for Shazad(for ufs and usb_1 node removals)
> 
> Changes in v3:
>  - Added Acked-by tag (Krzysztof)
>  - Renamed dtsi to sa8540p-adp.dtsi (John)
>  - Removed copyright from sa8295-adp.dts and sa8295-adp.dtsi(John)
>  - Added cover letter

Johan
