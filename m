Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399C76D18DD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCaHpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCaHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69464191CB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF8E6240B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B93DC433EF;
        Fri, 31 Mar 2023 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680248738;
        bh=taMOt2Lov9rC9wpDUTDWzToA4PfDhmbtIVAXI2i96Ic=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FuLEiqjaRr490CXNwsFErE3yuBFxsWciBgGaYYoECVLftMYwMMO2ruOfHprtcmCsk
         eUqwKrz7qhr5S1OyWJHZB0gLvvERrDlvf04ZpWo83rwHBpqgvpVIALxrolbGH1KFGn
         MsDOYe4VZIWKTVjbOzgr4C2sNaKjoMoeVnmnANCzoCkFheMQ4owoXLKDF2krsdYOYV
         nTNlH49KesfOI7wS3iJoUUzAhQp8KQh8wrdHKph5a8STu+sVyRoNQiL0ODJ9e9Y81h
         M86mpYYx8VyBRMaSjlxXTFDnbjpQP7OeZAo0FaByk53XupbHTD7l2n0oP22+K8+JV/
         kwDqfCtESoxwQ==
Message-ID: <38143d66-ad7b-9d13-5280-126bd1f077a4@kernel.org>
Date:   Fri, 31 Mar 2023 10:45:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] phy: ti: gmii-sel: Enable USXGMII mode for J784S4
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
        kishon@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20230331062521.529005-1-s-vadapalli@ti.com>
 <20230331062521.529005-3-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230331062521.529005-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2023 09:25, Siddharth Vadapalli wrote:
> TI's J784S4 SoC supports USXGMII mode with the CPSW9G instance's MAC
> ports 1 and 2. Add USXGMII mode to the extra_modes member of J784S4's
> SoC data.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
