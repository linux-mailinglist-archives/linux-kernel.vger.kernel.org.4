Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1135FB34C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJKNV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJKNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:21:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C995AF8;
        Tue, 11 Oct 2022 06:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 179DCB815AA;
        Tue, 11 Oct 2022 13:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D89C433D6;
        Tue, 11 Oct 2022 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665494416;
        bh=7BJj9ntWujvZUcRvi4blwOWkNq/G60WMX4wF6oHAeQQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tNOdFCFKizRJfRKHmI/dGPJqEoUNa+6wHGLQeo0I+2Xgel29gy4YF17yr0suhuKE2
         v2o44G/WteBZnGRRtj2q+mTdvhJxgvdF3CO//ON4rpdVac9WeA3LZVG3zMHkdQ2VEr
         bOpf1ivzEy7IxJVHHKVWSEr41l42HiWhViWaU/qzWj2lzkvrgGc1wxTYKJltqYJEjX
         K/SWssMSh1D1aTtHWAehhwJ6h+p++7G2gdYBXpYQz2Gno5FFlbqClxaIoikTLJ8+on
         9qg9/H7/+54gDjk6Zyyu+FjzrEoCWRSU8WVCf49oM4WGhUjk8RVSA6EyypRJ5X6R++
         fF0ZcPazdNvHw==
Message-ID: <e028ad6a-9687-5089-4938-e982764b9c58@kernel.org>
Date:   Tue, 11 Oct 2022 09:20:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V14 1/7] dt-bindings: Added the yaml bindings for DCC
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <e320555b2075c94946ef3f9c78732dc84ba39449.1664383851.git.quic_schowdhu@quicinc.com>
 <4d0f7a01-1995-1b1e-40b9-125c3447b8c7@kernel.org>
 <78b42aab-164a-7fe6-fec5-77f52199c641@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <78b42aab-164a-7fe6-fec5-77f52199c641@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 02:59, Souradeep Chowdhury wrote:
> 
> Also the ./script/maintainers.pl gives the below output
> 
> Souradeep Chowdhury <quic_schowdhu@quicinc.com> (maintainer:DCC QTI 
> DRIVER,in file)
> Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED 
> DEVICE TREE BINDINGS)
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN 
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> linux-arm-msm@vger.kernel.org (open list:DCC QTI DRIVER)
> devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE 
> TREE BINDINGS)
> linux-kernel@vger.kernel.org (open list)
> 
> Will send out the next version accordingly, let me know in case of any 
> further concerns.

v15 and v16 was still not sent according to what you wrote above...

Best regards,
Krzysztof

