Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9177D74CBE2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGJFHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGJFGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9942B2107;
        Sun,  9 Jul 2023 22:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1F060DEA;
        Mon, 10 Jul 2023 05:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C775C433C7;
        Mon, 10 Jul 2023 05:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965504;
        bh=4PTb+g/TqTcyRd4oXgTbdUdJ7aTjn4SwwMYjIto/gPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMurFh1saLmWYaF6qZI2zUQtDPjw5DgP7wGjWgj3I8oJuUn/L2vqMms87tFCBaDXB
         9K0HsFOzJbrTKb37U0IRd4AE9YrYO+PYuVHR7CU8cSp9ZDTLec2pxZ7GJyZ7P5n31G
         cf4X4xvuc0AodXoCR45/ViVm+g8apJg7a1ou9KsuHLN7KyjLo2ymqIuMj/stuIX0J9
         wVIUl1gfMOh8cAvv7BF/v+A3NODe0/xL/0jquatbcHu7ohchTBsxDvdXMzL3JvwVEf
         rboWfCEKC6UtPtwNM441+q7HPLtx3aQlVq1JEHkGFWSyKVXfn2mcma+2c3mI7yRl8s
         DyjJ/xQGPCNTw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Drop undocumented "svid" property
Date:   Sun,  9 Jul 2023 22:07:42 -0700
Message-ID: <168896565942.1376307.11266871581531850569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230531024944.4105769-1-quic_bjorande@quicinc.com>
References: <20230531024944.4105769-1-quic_bjorande@quicinc.com>
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


On Tue, 30 May 2023 19:49:44 -0700, Bjorn Andersson wrote:
> The Linux typec_mux implementation required that a property named "svid"
> was present in the remote node of the of_graph for a match to be found.
> 
> With the introduction of commit '4aebc4f89f00 ("usb: typec: mux: Clean up
> mux_fwnode_match()")', the implementation is aligned with the binding
> and this property can be dropped - and the associated DeviceTree
> validation warning resolved.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: Drop undocumented "svid" property
      commit: e0f250c8fd012b010cdae0535903402765f7ffe5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
