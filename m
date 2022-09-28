Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F705EDD61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiI1NBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiI1NBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:01:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D99E887
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664370058; x=1695906058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHApcl1cxDfDCuGSHDoGSRDESVGp9gz0p1Nl7f1hK94=;
  b=fa3GgqZLorEGILfl5mBAupmZtePbknO1kVeHSxufaF2P5YHvotag9HDo
   GymPfhIZGIpZrLpfJlJbMFieX6o/isGMoIuQgyeygoZ6D99MNvDuCPgDx
   D0aewOxY2/OWKYlkB25s6wLpzaCBRbLsv7QS1xGZhJeUp4tptyaqkog8k
   Wr5tOz210IuJTtJlYbv2JDPxd4uw9PjGQWdt6I4AoUF+04YVc3npxbs+y
   xkz69meDIKpsvWAYjLxuLJdYENR7b47GtrAToFTUbzaXp/vNmOfcV8Foy
   l8ZIyrqz7YArlRmqZhJtc1Ysjo/Xs2tHlvx7dB5Iu0FI/j0CJrcp+ns2R
   A==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="179311806"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2022 06:00:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 28 Sep 2022 06:00:56 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 28 Sep 2022 06:00:54 -0700
Date:   Wed, 28 Sep 2022 14:00:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
CC:     "cl-cheri-discuss@lists.cam.ac.uk" <cl-cheri-discuss@lists.cam.ac.uk>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "cl-cheribsd-discuss@lists.cam.ac.uk" 
        <cl-cheribsd-discuss@lists.cam.ac.uk>,
        Wang Kui <wang.kui1@huawei.com>,
        Jan Erik Ekberg <jan.erik.ekberg@huawei.com>,
        "Horsch, Julian" <julian.horsch@aisec.fraunhofer.de>,
        "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>,
        "Ahlrichs, Vincent" <vincent.ahlrichs@aisec.fraunhofer.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RISC-V CHERI port
Message-ID: <YzRFcaNFZ7LPzrLH@wendy>
References: <1c0ba05578f1487980b071da1377fb3f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c0ba05578f1487980b071da1377fb3f@huawei.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:54:40PM +0000, Dmitry Kasatkin wrote:
> Hi,
> 
> I would like to inform here that our Cheri Linux for RISC-V work has been open sourced.

That sounds great - but unfortunately I do not know what "Cheri Linux"
is or what the "RISC-V work" entails. Do you maybe have some links to
relevant material that you can share or a brief explanation of the
benefits?

I can only assume it is this? https://github.com/cheri-linux/linux

Is it something you intend upstreaming?

Thanks,
Conor.

