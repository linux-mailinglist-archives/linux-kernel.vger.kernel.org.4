Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D0374CBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGJFHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGJFGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158FE211F;
        Sun,  9 Jul 2023 22:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B77160DD0;
        Mon, 10 Jul 2023 05:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B114AC433C9;
        Mon, 10 Jul 2023 05:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965508;
        bh=2JLIFzFsVyog04P7JpsSjL6KUVHJHPtsfrpFBog8Q1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTyA7QsmBBS8HFBf+P/Hn4iF9fSGcyAfSYudQo9scRg4feU6ekRmh85Nriyqt0I16
         yVPg8q4r8s2md2R2hJ65VV9F05S/Z2ftp4QsXgOSCEUibQV57crXRr3pL5RMktGzkb
         26/wlt41we7KXm/eGeh7Zv/tCnopWIko/Ap+D7vV68iJ+t/QapdAmJty+nBufOQ1rR
         S+QAQtdL+TrPqzLRqP7wPwZMHcPudltNhrhUmltlUsEZq3ljuRH/QTedqCcBbTBVB8
         xLRVKLvADhh5r19NL2IcsMxfyE6R+yjoP8ec5/YQYy9QMZHLzXnAGpiIyu6XS0/wTE
         1OBJiQOTQGYQw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sridharan S N <quic_sridsn@quicinc.com>
Cc:     quic_saahtoma@quicinc.com
Subject: Re: [PATCH V2] arm64: dts: qcom: ipq5332: Add common RDP dtsi file
Date:   Sun,  9 Jul 2023 22:07:46 -0700
Message-ID: <168896565970.1376307.15602806741740592706.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623090001.27778-1-quic_sridsn@quicinc.com>
References: <20230623090001.27778-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2023 14:30:01 +0530, Sridharan S N wrote:
> Add a dtsi file to include interfaces that are common
> across IPQ5332 RDPs.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq5332: Add common RDP dtsi file
      commit: 6d5872f2ccbe4ebd6aa926e3699a760356009dbb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
