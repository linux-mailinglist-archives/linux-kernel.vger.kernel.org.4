Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B5E65B077
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjABLXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjABLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:22:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29699241;
        Mon,  2 Jan 2023 03:22:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB20560F37;
        Mon,  2 Jan 2023 11:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186FAC433D2;
        Mon,  2 Jan 2023 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672658526;
        bh=NsliRdZaxPkfi38ZXX6vQ+MBs+Xqv26nZtoV92gg+YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6lNPlsJcPnXiYXZyBDpTbzfbt1MJ7RWOMJdRYDLVJCY8pn+hy9gerBbWm8pKtOnc
         n5/AZ1G5di1CiGIgf0TwJpT+1RHXDRkxe2wLSY/Y33KJl7yHZnGL3btp02LejGEGRy
         Ywvh5jcuBlu90ERP3V511BOTvLpdWlTA+OQ7K4dzl9MDrEMYMEqxDC/apUuH35T7DQ
         zCm9oabcpRz1B2m1YxsZx6rzTJ1mlp5rb3PjO3SPTRwTwe4Lsy+HTeMm56RnNp3/Jq
         QQNirxRWUtCPrwdQUG6H4MeBsCdzMmZ8LhOrYTCwzD0Wh+Izh2i/VWObVWKB4VO3eR
         hhsNdsBPCZMCg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCIta-0005Cf-4f; Mon, 02 Jan 2023 12:22:22 +0100
Date:   Mon, 2 Jan 2023 12:22:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250-mtp: fix wcd938x codec node
Message-ID: <Y7K+bniJmFdVv62Y@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-6-johan+linaro@kernel.org>
 <77bd335a-1989-2d5f-d480-d388e141ec91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77bd335a-1989-2d5f-d480-d388e141ec91@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 12:15:50PM +0100, Konrad Dybcio wrote:
> 
> 
> On 2.01.2023 11:50, Johan Hovold wrote:
> > The wcd938x codec is not a memory-mapped device and does not belong
> > under the soc node.
> > 
> > Move the node to the root node to avoid DT validation failures.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> Could you rename it to audio-codec and separate/sort the properties
> like you did for x13s?

Possibly, but unlike for sc8280xp, I don't really care about these
platforms and how their DT authors have chosen to order properties so I
left out the clean up bits on purpose.

Johan
