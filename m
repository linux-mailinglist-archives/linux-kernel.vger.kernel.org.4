Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF29712C19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbjEZR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjEZR7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:59:44 -0400
Received: from p3plwbeout27-01.prod.phx3.secureserver.net (p3plsmtp27-01-2.prod.phx3.secureserver.net [216.69.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B195C9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:59:43 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id 2bj4qA84BTkrI2bj5q5Ur5; Fri, 26 May 2023 10:59:43 -0700
X-CMAE-Analysis: v=2.4 cv=PP7KRdmC c=1 sm=1 tr=0 ts=6470f38f
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=3-RhneuVAAAA:8
 a=FXvPX3liAAAA:8 a=fedbvfDaUbvpSB96acMA:9 a=QEXdDO2ut3YA:10 a=SM4aVyO6fsoA:10
 a=7Bv5oc6oNHEA:10 a=VLVLkjT_5ZicWzSuYqSo:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  2bj4qA84BTkrI
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.87])
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1q2bj8-0004uX-K9; Fri, 26 May 2023 18:59:46 +0100
Message-ID: <dae2dd0f-5efd-499b-9684-1a6c2c01accb@squashfs.org.uk>
Date:   Fri, 26 May 2023 18:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mm-nonmm-unstable v2 2/2] squashfs: fix page indices
Content-Language: en-GB
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230526-squashfs-cache-fixup-v2-0-6fb7723c3647@axis.com>
 <20230526-squashfs-cache-fixup-v2-2-6fb7723c3647@axis.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230526-squashfs-cache-fixup-v2-2-6fb7723c3647@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfEKsHEaOE6j4rLwKOv4uNke4uAODdFHfmUu/2oFgT8uXAjXr10GEQV5BgryBs+iDBU5+aiVVdp6sB0AHwfYiDuPn1pyNHvzmIfz3G/JjBlSKKuVFVDt7
 9M/Ucfo9+Lo8puGT+yZfc3DNVvicEBnlcPUoGcdfkK9IBgT1UKW+WTp6XQPGhy26CqZuGgXZkmbZ021cULn10hmwuFjhlf0RHFE=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 14:57, Vincent Whitchurch wrote:

> The page cache functions want the page index as an argument but we're
> currently passing in the byte address.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
