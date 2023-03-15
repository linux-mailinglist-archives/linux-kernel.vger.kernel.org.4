Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E406BA496
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCOB1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCOB1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:27:39 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B222BF32
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678843658; x=1710379658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qwAtZoP7xvSgcHN363+jUE5cgyYDhp6d/HHlumIaPx4=;
  b=fczZnC7u/8zIpYBJVWZlIe3/Hgsw/X/mRutKNZxJsE94KyOw0WEIqM7i
   hNKZ1r/CwJ9dVbpv0gwm3LfFLAu9Sz3Iqcx09hw9Cgju9pUV5Mu1KLZ4V
   d/HvhNtcNNiucmpYnP9rKo7/dNjzjy4lfZb/D+vtfsF+JYcGLzXhwdFk3
   N1Gj/d9qzqk9KvydblzrpYXYf2D/MO0IM4Vx6uI405MYL4URHjsmJmqF+
   RoYttclxpJ6XWKwaioEEvZ+SKCSq3ATfUYEIoHh9eIYQ+lTaRDeL5MOyK
   vkOVKhBhe6Yy1SypLxTtaetytgvNj+adhtUJdJJYQxhb90EIIoEe9ngWm
   A==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="337671859"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:27:38 +0800
IronPort-SDR: 3G3PyXWimhQu3L7ucLF2GzKRfebB3ZLuX47lBQPsmVJ0dXfk2NL1+eQYMRoIMWAnQGCuVkdsQM
 sVZqUIvhQbeEqcBKVXIiKx2KFAgAE9e20LuJnqga7kYPou/EGmwoY7ECOw9S6H5hNU15DPea36
 AUKo9dMNo/QbRygxuBmTgO7DGR02IZPRbjFLW2fcg4fRCPsVcBzYl/N6qxvedownRLOfv/yyNY
 xeG1RT388ajaG2Cjxafxc448chfo8o4FoO8r1kReRIW+lxYmzOA12A7c/rZZcMiNgh+9GncPBD
 vVA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:38:25 -0700
IronPort-SDR: dqtD22cynLmtABuMILcqBfjWauXBg328Y6ZlufLvTU6IsZbenDcCGOAhA/HApUEPmuU8jMp4JQ
 bEfU6V83GFvh5gGrLFu01smeT8qR7gR+XDZxNjYDH/gDckEsFhNLa/5UbhXe5xQ90x9zPI4t4G
 M4CELAOyk1ObQjXXaN/j729ASSJ+nafqpCN25XkfSoss5GOkjXPAbBN+6GIFYKEIGTQzp9UNhq
 BigjeECRXlojSBR8VMeUt3Cu9yQU3Qr2PYVedeOaj547x6H/ho3GVD/igEqXZ6xvsgMNPBSyob
 9zQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:27:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbt6y2zYlz1RtVq
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:27:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678843657; x=1681435658; bh=qwAtZoP7xvSgcHN363+jUE5cgyYDhp6d/HH
        lumIaPx4=; b=hww0MhteHuQE2OdTQgZ104gsvu1dm95/Sgs5XP1tYfw8W4Wyo/p
        pnI2T1XnQlx2yQE5HBC0pwdUPgvGPAzJGV/+4hcLnLrc7xLjZL8YFOFuVdVGXlQb
        AWrA6gMkBEaPLnOB4Wfv3lrZMgSUlXCVtcaq+f7TpUI3OIf4vHBedoFyCA8hrC1u
        o7ftGMYVJ+5uzMr8nUFTSO/ttvsCrMQtQxmEH2f5Ju6LwZiYxz5wiX42ozrMD4Fh
        sTYoxzlUZ0bhHKjLQBx0e4aKELYcO2PYXdWcHkxQwk9QTLiKl38B1SvjkL/3bBNG
        I0W4YW6JeQEdAc3xYJVjhsBVin6k++zOHKw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OB_5AzcFYNl2 for <linux-kernel@vger.kernel.org>;
        Tue, 14 Mar 2023 18:27:37 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbt6x0Kkyz1RtVm;
        Tue, 14 Mar 2023 18:27:36 -0700 (PDT)
Message-ID: <80210bb6-edc3-450e-4816-9fe0c4b8b07b@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:27:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 resend 3] ahci: qoriq: Add platform dependencies
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Li Yang <leoyang.li@nxp.com>
References: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3b6733f683c13ac02093206e76a3e30c7d045366.1678279668.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 21:49, Geert Uytterhoeven wrote:
> The Freescale QorIQ AHCI SATA controller is only present on Freescale
> Layerscape SoCs.  Add platform dependencies to the AHCI_QORIQ config
> symbol, to avoid asking the user about it when configuring a kernel
> without Layerscape support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>

Applied to for-6.4. Thanks !

-- 
Damien Le Moal
Western Digital Research

