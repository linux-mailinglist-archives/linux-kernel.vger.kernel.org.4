Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319536FDE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjEJNAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbjEJNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:00:01 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45286DB;
        Wed, 10 May 2023 05:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683723591; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=f1qrsQ5v0cBuW5MMpZYzWdW4Lyt88nnz9Q43oVnJ8ZytlKNiS6XWRnkDUX1TXM4LdttWinhLIc+4t84qJ6bxpYu4T9ZfF8FIX8smDh7zthKIFyFIUKLktdaFueFSBrUqbgNi/Bmod0zbKb+VkQ2FsuuQiq9IgFOFy3ouqHjCmnk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683723591; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5hqWrQ1lyiYlCqlRavsX79hg3zLYq9IO5n504NEHH0g=; 
        b=m6OO/zLtxeKxZ6rexTqu5FsUjCezqjH6IIBeNr5y63c6OEGB3HCd5nvUKKJZBNMANWJf86Ay1eSHmo+L1sXZXc2lG1C4nnQfaeWypNxt3uIwaFapxxsAhrOGw/joxFPK+PrTBEsr6T0dXmfZhj+NAHA/rzqQl46pdKxDBUV3CAE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683723591;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=5hqWrQ1lyiYlCqlRavsX79hg3zLYq9IO5n504NEHH0g=;
        b=JitB69XFjSvbX5C93Q3k2Kjn2ZIPHrGk0ZBcPMNSgnmMlZj3evYg6/n6jEaXaG6U
        Lo3p/IdLW8DrKKuefJ1Hy8nzbC6NTHhKB4ZefKpblL+S98ZpdtqtzismI1fyYJ9YQHp
        2z50RV+dLtt4tE09D3cdPVubhTTHPFWY5WRxatD8=
Received: from [10.1.111.147] (185.242.250.116-ip.operadors.cat [185.242.250.116]) by mx.zohomail.com
        with SMTPS id 1683723588464419.30319491106445; Wed, 10 May 2023 05:59:48 -0700 (PDT)
Message-ID: <a5fdd37e-6f42-2f37-357f-ad5bb082fa7d@arinc9.com>
Date:   Wed, 10 May 2023 14:59:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mips: dts: ralink: Clarify usage of MT7621 ethernet phy
 arguments
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230509200032.308934-1-liviu@dudau.co.uk>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230509200032.308934-1-liviu@dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.05.2023 22:00, Liviu Dudau wrote:
> The device tree uses numbers as arguments to the phys property that are
> confusing for newcomers. Define names for the values and use them in the
> device tree.
> 
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>

You should document this on 
Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml instead 
of doing this. Under the phys property, add 'description:' and explain this.

Arınç
