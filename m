Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896D865F607
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjAEVqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjAEVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:46:07 -0500
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C90263D28
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:46:04 -0800 (PST)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id DPj0p4FdlE9lPDY3np48os; Thu, 05 Jan 2023 21:46:03 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id DY3mp9Tj9LXeLDY3mpe3aL; Thu, 05 Jan 2023 21:46:02 +0000
X-Authority-Analysis: v=2.4 cv=EvfBEAQA c=1 sm=1 tr=0 ts=63b7451a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=RvmDmJFTN0MA:10
 a=wYkD_t78qR0A:10 a=_AnF1TBu_7nj6opTY8AA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5/V2r2a5Cu2IhUj3HX5PU+deO7d6p4CisNPoCytN/tM=; b=sOgtd0Y+rkEyNCoNO+FTjWhzFL
        +t5D3G6TTU9p7iRRsEg0k/1kvbu6/MtMFdlEiIFbIUzAf6IZe8OmkUMlOlCJZIEh2Umn1yD7k/upm
        V7hwbi8XY04bQPaiizq2Y6e5M3xHpaGBzyLqZSZiv7+/WxAkJbCG8P9fL7zW8oqJBepDTnT+Ktnrc
        cCT5t2qUQbVHOhKXBPmeVw0cdOhGRtfZt5Wz4oF3z3FZ3cOBpRUekXKzLZUOnx6XKTHAmRhGGDYYR
        yuXXA6JFuwDRI+670+4HqXGswrhf3v1YUm8cFiiDRlw2hz40+Srcym7UZHNcoUKu6fqkX5G1aoIal
        /QIkJpCQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:56610 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pDY3m-0015Yp-7O;
        Thu, 05 Jan 2023 15:46:02 -0600
Message-ID: <4d8e55b8-6f52-6261-b406-4dffea62d5a0@embeddedor.com>
Date:   Thu, 5 Jan 2023 15:46:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: duplicate patch in the kspp-gustavo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230105085250.03cb9321@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230105085250.03cb9321@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1pDY3m-0015Yp-7O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:56610
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNo8nH+VZSlYz/rdamk/cSItCF29CWtJW0qDwTmNZR+P4XFYglgOBwyxQarI69QULpHGT+epNx8JNqDoIuJRHHXDeRHbhWKA8z3LVQ4FyBo/eiuPmLgN
 LG/NfMavbF03hBfJWPNdkWOoVaJBm7CwkYIfbsSeKKAfqWSGr3yZrq+0q5/8BAjnCbpk9aMcbIwkVSxbWyWGgqyO/8VsNuEtaUngcw6Hifqys8EVgJ6ITNDk
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 1/4/23 15:52, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit already exists in Linus Torvald's tree as a different
> commit (but the same patch):
> 
>    7626d500ecca ("can: etas_es58x: Replace zero-length array with DECLARE_FLEX_ARRAY() helper")
> 

I'll remove that from my tree.

Thanks for the report!
--
Gustavo

