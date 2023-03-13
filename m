Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC46B8085
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCMS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCMS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:29:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37B882A92;
        Mon, 13 Mar 2023 11:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D13661468;
        Mon, 13 Mar 2023 18:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01344C433D2;
        Mon, 13 Mar 2023 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678732060;
        bh=/UptELta1fbfIVlSU3lW1JfbEsBBjNSMIYGDMc0a6Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvvKyry0IHRmRY/4zqVRDhYa1hlwWP5XO8DPtmSV86lG3jJNM7uxAeqCM3/hMjEnS
         /4fGZINOj3BbOFj7VtuSn5/zADgew9/AhucSrWiCDWCAvWqK46vpsQ6ipb+6neCHzX
         D26bSYYK00ZZp7wS/PyFzdSBom5Fc1YvU4I2sz/4csGzme6PYNmreJ9TJMdSLn2pJ3
         cgxXHKzmvZ0aDqUoSafiMpZKQIjdbzRSu92/wVYzEbmBwzFm5rb1KpTZ9Ix5kcdW8E
         IH7F21aKBHvZjZ0vyXFvDpM4UNcMSFajBrFy3LzzWeznIYwqpqWY/2y3YL9Y5Kytyi
         kj7t2/qKpgCbw==
Date:   Mon, 13 Mar 2023 11:27:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/7] dt-bindings: mmc: sdhci-msm: Add ICE phandle
 and drop core clock
Message-ID: <ZA9rGihWeLhUYMdA@sol.localdomain>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
 <20230313115202.3960700-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313115202.3960700-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:51:57PM +0200, Abel Vesa wrote:
> Subject: Re: [RFC PATCH v3 2/7] dt-bindings: mmc: sdhci-msm: Add ICE phandle
> and drop core clock

"and drop core clock" should be removed from the subject now, right?  Same for
patch 3.

- Eric
