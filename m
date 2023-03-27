Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D06CADE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC0St7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjC0Stv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388DC3AA2;
        Mon, 27 Mar 2023 11:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C79DA61474;
        Mon, 27 Mar 2023 18:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D9DC433EF;
        Mon, 27 Mar 2023 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679942976;
        bh=jLpV4aLEaWhnj2ZeSXlyZ4XrVCotJyZACRst+Ac2PsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rd5hRxyfDJ/6AksAtofExgq4NRAeL1yIwf+eXcgpeStZ0wYSYQNeSv6Lz1SdNx04f
         71t7VD8RAxgbPs6ATLN4wAQWolJcZ2UwWc2RNt2OnX2NdB8BCD/YZyhzKyetRwFL9I
         2vN/eCphpT1Nx2q956+8o/nZkpu8cVO12JuIjRd9is4Rpg33jrmTn4xo4qJTvqDNRA
         eaXBmZJdkWyVXTSun5xEyvRFPNVa9d4pTe0lOoj12RlY/3OblQV0rsWke7kiqb+Z3S
         negqyzWgL9hlvX7CR8QJhcDX9IHk3F+KUtpVsPmm00OmRq75PxAjBKPCSuE+TbGCQv
         ACN2NpvYai5kQ==
Date:   Mon, 27 Mar 2023 11:49:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: ufs: qcom: Add sm6115 binding
Message-ID: <20230327184933.GD73752@sol.localdomain>
References: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
 <20221209-dt-binding-ufs-v3-1-499dff23a03c@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209-dt-binding-ufs-v3-1-499dff23a03c@fairphone.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:41:28AM +0100, Luca Weiss wrote:
> From: Iskren Chernev <me@iskren.info>
> 
> Add SM6115 UFS to DT schema.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
