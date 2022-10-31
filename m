Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0648613A22
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiJaPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiJaPfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B386381;
        Mon, 31 Oct 2022 08:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0908A612B9;
        Mon, 31 Oct 2022 15:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228CEC433C1;
        Mon, 31 Oct 2022 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230544;
        bh=pGTJFwR04wAznT0VzOzzd5AeSlMtz89Bp8m8aRJ8gfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=roK6HfqMOk/p4FlEw5sSzRKH3/jIr6RZYUBRfcuuKaGeatRnGE3w95jqtWtYsXBKD
         tqiODQ0+ZKbSO39UEHiswBWb/T8iGIMAEsK9OADzVUJyrtOKuu7HVBfLCm+piJAvPy
         0JYa2Sxait1J4wKj3DPRZC9HtoesTJVtq2hgRoSS86c1IBtkZuqjmZ46ndi1ahi7Kn
         ftpiup8Cdoz7EFoR4EhRHatapzXwld/5exqdm3NIRKmPR/EpOiQnrRlSqU8FigUTr7
         xB4lNDrVsvhotmHJP3MfmaEtHLtnU+odLLUrCIbyRqE8Q0Oq+oBHBmch0uKRwBqQIV
         10sOPD00Daf6A==
Date:   Mon, 31 Oct 2022 15:35:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Open Source Submission <patches@amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10 1/3] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro MFD driver
Message-ID: <Y1/rSQ3tt+a/fYzL@google.com>
References: <20221031024442.2490881-1-quan@os.amperecomputing.com>
 <20221031024442.2490881-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031024442.2490881-2-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Quan Nguyen wrote:

> Adds device tree bindings for SMPro MFD driver found on the Mt.Jade
> hardware reference platform with Ampere's Altra Processor family.
> 
> The SMpro co-processor on Ampere Altra processor family is to monitor
> and report various data included hwmon-related info, RAS errors, and
> other miscellaneous information.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v10:
>   + None
> 
> Changes in v9:
>   + Update SPDX license                                       [Greg]
> 
> Changes in v8:
>   + Removed unused #*_cells                              [Krzysztof]
> 
> Changes in v7:
>   + None
> 
> Changes in v6:
>   + None
> ---
>  .../devicetree/bindings/mfd/ampere,smpro.yaml | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
