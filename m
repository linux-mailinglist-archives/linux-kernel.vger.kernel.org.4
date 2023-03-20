Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9916C14FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCTOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCTOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:39:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81389CC0F;
        Mon, 20 Mar 2023 07:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DB6461551;
        Mon, 20 Mar 2023 14:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607AEC4339C;
        Mon, 20 Mar 2023 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679323177;
        bh=TMmbW+cR0Ww7zrPZPoAPWl9ooanMqWYfTSDibgGBb3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHm0N0Ic99KHo2XdkiPlGeo1WQDieOsMdUrSVamYUOn17UrJvLTKGJelVywzoAbEl
         2uovKZL56DoZl+0qwvPYq5znj8JHz6Tm0iJ8lmOsfqcmN2qzxlg/npYXz1bqOB/dcF
         65krg6U/NUTzT90ZKUocZP0iA+kLdAPehZGtwLd1pY5cs0lxVgUBBT3z+NpwTPgN4w
         uT8Nq6J3Pvb/20A5jFmMbeoWqbnEZmJSwnnYCbtn7AKV13rhzfq6Xzk2Dk04YHeLKx
         DGEmB29oBpnhcHyxS0embAluzgZDmIGF/3c0AK3LsA1Q4dDY/tIGYS2MLGUmFNvcK9
         4XXHD3lfRMfxA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1peGh0-0000o8-JQ; Mon, 20 Mar 2023 15:40:58 +0100
Date:   Mon, 20 Mar 2023 15:40:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: qcom,spmi-sdam: fix example
 'reg' property
Message-ID: <ZBhwevJxxEz2I4i9@hovoldconsulting.com>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-2-johan+linaro@kernel.org>
 <136736ef-2502-0f09-1c09-02fbf155ae4e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136736ef-2502-0f09-1c09-02fbf155ae4e@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:12:41PM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2023 14:57, Johan Hovold wrote:
> > The SPMI PMIC register region width is fixed and should not be encoded
> > in the devicetree.
> > 
> > Amend the example with a parent pmic node with the expected
> > '#address-cells' and '#size-cells' and fix up the 'reg' property.
> > 
> > Fixes: 9664a6b54c57 ("dt-bindings: nvmem: add binding for QTI SPMI SDAM")
> 
> I would argue there is nothing to fix - the original example in that
> context was correct, because examples have size-cells=1.

But you'll never find these PMIC functions on a memory-mapped or other
bus with size-cells != 0 so I'd still say that the example is broken
(and it is definitely misleading as I found out the hard way).

Johan
