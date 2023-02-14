Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA5695773
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjBND2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjBND2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:28:01 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF6716AE9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676345280; x=1707881280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x7YyVY/jHHAB7fpCW4JZQOTnIZ+pcM1OEZf7EKFnVMk=;
  b=UQqLGJqIOR0GM72FKe9rldTV8h/ZPsrTMEiHUA4PVqUpIHQpfJcmkBBB
   pB8Q3BxXOQOM5VmLE63nyp3OLbma742CljMZUucYFfbRXOu8Y3FcbeY5Y
   Cd2TkQp/ikRc0FP9eQjEJhsaeWdgHQUvWp1hiM9YrJlQCnhKGl9MF3ssG
   15X1ychQvVjhGnakn/GpKg3kPDiRHS6Qzg9vQos9cmBNp++UbZU4+BAFZ
   Y07CAodZkIDM5UTMCd02I60DRZjad4rqVrLku9JGx9QJEPLuN7K+KNSRb
   y13y63QKsIVhixgJqVmT03UHUOI9PFRgXtTPxkkaGxZQRhvVQPGzAIarA
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="327531636"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 11:27:58 +0800
IronPort-SDR: CRrFRk/RqnhRc4S5hCIRwTxSuveP7VlxrLfJzWrCYNu3i9iMwdZL0pD3D7kbLrujTodrkBpfXC
 CsA3Sg8Jf47jF4HA9cx/B41NPeeOUQvBdFYBAQDu931SO1wJaFXyhyYLiLoIvRI1eRNF/EtYq9
 XVXUQXe7DkR4QnsVjCcPO7i6A0IkEiLClu1LGudgxZFn7sjuhBHryVV/XBf3eHo2wpIp5FyUPd
 KIwnpmQpS/n14+Le4i9w0cBD4UBE6Ts52gTDxRyQpXh4Xy8PEXn2Xf6CqXkb6pfaZqn7m/WACl
 EHs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 18:39:23 -0800
IronPort-SDR: PljZDoA9rMW5gvzvsaBibRhcA+1a84OoqZT5iGfMtY0SUG2LbTkzljdrS9cU2JC7A96aTKNTd2
 sb798Qkzdo6bO9ZBnEGZm+vGqdn1RLAJE2FQD9mhk6p2KRBJpO4vcK7799JWo2oR9iheGSqcbA
 OootL/GZMsUgx50mv3DDBh458tRB4Qtw3coWiVlQ5N/4wpnu6l98MXt/ruVqvF9VNXxdd1fuxE
 X2xFVnPBGWjVojZSIr6QULKxAwq41iGnxN9dzeCZuKRFxAH/oChlcwSZd9gSLeaVaVmxS7++0E
 eO4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 19:27:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG69B4gDQz1RwqL
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:27:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676345278; x=1678937279; bh=x7YyVY/jHHAB7fpCW4JZQOTnIZ+pcM1OEZf
        7EKFnVMk=; b=B4m9jBTFsbAsqtZyw8mA5MpFhxjTSCHBlwdei7RWfEb1jSemRdq
        C5cOkixbuwjJ3uXpJOWE6YxijWDbBkcWb9ukf14ycyfWYJzrTSGc/4UMuvANWquo
        9S0YFZfkDdSCRboYBdCrFk88TeGrGFHHLKmN+onyWnGEDFxGMyqNlv2i0UmqbZ26
        fhVkuykoV5nPiMNP0l9hMsTcKuGVS2+81F7nmpT4zCJdpVFgHHBsRGDQG60nBxT3
        Mhbwk6nXe3j/B9haFvsGdKmjPfq0xw1ePqF7aKXvDAhAHsSR0/X/ynuWfB4UqJHl
        Clu7WyZiLhO2oueW+3xQbQgJUTS0YwennEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y3I0E3a2CSoh for <linux-kernel@vger.kernel.org>;
        Mon, 13 Feb 2023 19:27:58 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG6994vVMz1RvLy;
        Mon, 13 Feb 2023 19:27:57 -0800 (PST)
Message-ID: <51d8201a-5677-e024-8ca4-f0c73795884c@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 12:27:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: libata-core: Disable READ LOG DMA EXT for Samsung
 MZ7LH
Content-Language: en-US
To:     Patrick McLean <chutzpah@gentoo.org>, linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org
References: <20230210215151.812839-1-chutzpah@gentoo.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230210215151.812839-1-chutzpah@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 06:51, Patrick McLean wrote:
> Samsung MZ7LH drives are spewing messages like this in to dmesg with AMD
> SATA controllers:
> 
> ata1.00: exception Emask 0x0 SAct 0x7e0000 SErr 0x0 action 0x6 frozen
> ata1.00: failed command: SEND FPDMA QUEUED
> ata1.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
>          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask
>          0x4 (timeout)
> 
> Since this was seen previously with SSD 840 EVO drives in
> https://bugzilla.kernel.org/show_bug.cgi?id=203475 let's add the same
> fix for these drives as the EVOs have, since they likely have very
> similar firmwares.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>

Applied to for-6.2-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

