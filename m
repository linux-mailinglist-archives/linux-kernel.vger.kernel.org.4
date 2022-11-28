Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562A863B60D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiK1Xjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbiK1Xj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:39:29 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C113DC0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669678768; x=1701214768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CKWGkAJZOpqvsRiv6iiFtDdJkkDaLWB71/7EyG0/hlw=;
  b=mvmsVDrbypFod3LMANxs/hJPkaSs77YrR6/EsDLwsw5U8LbjBT+/lcnl
   CI+3g2QKKmqx+QNf4a7sVqy/VIENFd6LwEWShZp4BygT3TZyaWE/Qa79W
   JvqY/JI/81+iSQshsHTUa46j/Dq87N5dFZ412Js11K2ChQdvBF5A87h6C
   hIS4qdqjNqh8JxbN3U/nLyb6Rgli7H/RQ3BTD6y3nq1WV+U5SBS+IfSg3
   SoOTz/18kygBbNdvdcf9u8mhsvk3aBSoqhkauIzIfc8PqPJ+tcSi02JFf
   pxp4egh8m3ONv4qTmWmvzbrw7F+ib4RFFC60fXPYGvjjoL0DaARjALvJ5
   g==;
X-IronPort-AV: E=Sophos;i="5.96,201,1665417600"; 
   d="scan'208";a="329497041"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2022 07:39:26 +0800
IronPort-SDR: sDnm8MVGk+MVGfoFAb+QKgUjEijx0DFfg7jLVHDmV6UkcrYtZqcWSVOJwdoMvEljyFb4RZoo4s
 xwbDMIACieAO//GS6j0YzVnqrAOR+Flk+/ByqWbxLuxpf9noKkOj/GwVMxt87IZXgxXmIF9439
 xTM2DEhl1MZp5jT4GZirE3iY4ax1s8djzxGfVIxUYo2Hp0a4K57UcXuTfEKpcTmZCLn8xpbhOE
 ubhGvPGvZ3mGHvnrYuiAhtYIY98ztZ1C8NSGdF4BoQSgj7xPKBhWYrEwH6V2D747vT3qtE3o2W
 Ano=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 14:58:07 -0800
IronPort-SDR: RFsDICRwxxTL5woQ5ki1LyKL70rcNl+O+d+QTFx7FiVQaqQt/qv7Oe7QZ4ZH9bYYdsOSCDU+Kk
 PGlvj1VXDC6l3oFic+ge8iRlcn21nRAZGRaWNv+4Yown4FPJlHJapUffI7Z6lwqNYXdSffGzv7
 Jx6/QMgfcQBC5ta+XGG55pt0LI1jNOZqzkmFMNyKbKIbj36dyKFd/1L8/JQWUJtUvPRZm6F5Md
 INJZiH37lpl0D7aor+B01HYnEF8xCUip1k/96klTczngi5laXcCnktEYq23GMWC/YOLDlzFy1m
 9a0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 15:39:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NLhl23bL1z1RwqL
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 15:39:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669678766; x=1672270767; bh=CKWGkAJZOpqvsRiv6iiFtDdJkkDaLWB71/7
        EyG0/hlw=; b=TH33QpIju2od0JJjgMhJh51ZiGLvuI5P1zoI0B7QZProO1P11d1
        fS251GW9UF6gA4O8Rw3w/0YkRK1PQpR7tGOC0DGWyPNlDGJwH+IzVWlo0HLQu0sR
        a0lTqCrz6ZUd4rsGcuQzPvS/r+0hIJXbbDZ8iCOEsZnpcKWjnMngGxaYJXXh2UVW
        VbvIXe8MTGwHt08eN9a3OvXhpUS8HYFkabXQDh1wl8XDWxjjeRA+BLjbDabxiCl5
        PRyPBeK2Dy+gU4H8FDa3L8AZjSr8E1wFPvRtvi8iiVAo4Z+egLwA5XWqKsdxcJWG
        22oIJxjj603T/rTv0WTSHlS94dqU4ZWe5jA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tFAtNbzJWx83 for <linux-kernel@vger.kernel.org>;
        Mon, 28 Nov 2022 15:39:26 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NLhl13M9hz1RvLy;
        Mon, 28 Nov 2022 15:39:25 -0800 (PST)
Message-ID: <ab5368d2-5f65-68cb-9703-23d6e451b775@opensource.wdc.com>
Date:   Tue, 29 Nov 2022 08:39:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221129082715.78e44566@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221129082715.78e44566@canb.auug.org.au>
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

On 11/29/22 06:27, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   4b49197f9fbd ("block: mq-deadline: Rename deadline_is_seq_writes()")
> 
> Fixes tag
> 
>   Fixes: 015d02f4853 ("block: mq-deadline: Do not break sequential write streams to zoned HDDs")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

Oops. Sorry about that. It seems I cannot count up to 12 anymore :)
It should be:

Fixes: 015d02f48537 ("block: mq-deadline: Do not break sequential write
streams to zoned HDDs")

Jens, can you fix this ?

-- 
Damien Le Moal
Western Digital Research

