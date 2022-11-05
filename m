Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F261DA9E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKENdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKENdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:33:39 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE17669;
        Sat,  5 Nov 2022 06:33:35 -0700 (PDT)
Date:   Sat, 5 Nov 2022 21:33:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667655214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxRvSPpDkfA4OD0jTkmJfdwd7Z1nb3hGsYjmz0KPJnQ=;
        b=oqch4dQvNpvDHRAep4jyoyCW9NyJxccw66ufHCjYLhBUF04rD/VSgUBLbpY6nJ7aoFkzqs
        4wqxBEV+zzNKrLsTwt+mXDNudSm7/vBic+2ovzjs4cJ3r50xWRARht551br8JAiS9HZ1DT
        EosekVyHCBli3IrQIrumS57LMDYgh/Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Rui Li <me@lirui.org>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/futex2 Chinese translation
Message-ID: <Y2ZmJ6bFeLi+xF+a@bobwxc.mipc>
References: <20221105041741.288094-1-me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221105041741.288094-1-me@lirui.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=556; i=bobwxc@yeah.net;
 h=from:subject; bh=lzpLYqc2X612vy5fFjAEe2n3C54VyB+hoiNMHkVJkzk=;
 b=owEB7QES/pANAwAKAbZbKBIigrCFAcsmYgBjZmYMdFYZ8jCUSPxMz56Sw/I4DHKS4wfVtE1l4tyJ
 Ea6qIdSJAbMEAAEKAB0WIQRFujdTmQmloK0WXU+2WygSIoKwhQUCY2ZmDAAKCRC2WygSIoKwhdvhC/
 4zgxwrzD9lbLv33RWS7URDJlisGot0tsgbub211VWMrdP9s2B/vfxuB1D7hZm5UVos51EFV0a8OZCT
 Wq13Prhj/anaHW2r/f/pKxGa12hitP63CJSVqrzoAOxvwPfO06NMYhF5y2CSY7TXdJ/2XAC5OzgouV
 q3LiscVxPhkr6Q1i63eaephcJr8uGepboUbXt0wStq+HBz9/8wqdNugt5LI6vNjxRLlpXazIdLZiXR
 qLHgccFn4ZbfDWa4ZYPNjjaR6Ch5IUFqyAW0TIM2BXMhrxBuTgT/dVnKqhat9ymvyK7bycrt9BHPAq
 jSZ28ccIH6armLWbtbVBlWa5tHkDYCQk5afst5RxEIi40drbFjEgSRIY/yvH4xFVflbsdLq0MpdSUQ
 bHjHz2S9UjQtmT4os7nu0k8sWsnlt0/3JENsbYh0UXSNuDZorSfV6+ryFY84H5Tis7+KMDT4V0Wmo0
 gcDXjTDK6iVu0IfRLlObeskFz+lP0nU7sY67jWNAzpgNw=
X-Developer-Key: i=bobwxc@yeah.net; a=openpgp;
 fpr=2BF2A4AA2F0730C3279ED01D32684A40BCA7AEA7
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-11-05 (六) 12:17:41 +0800 Rui Li 曰：
> Translate the following documents into Chinese:
> 
> - userspace-api/futex2.rst
> 
> Signed-off-by: Rui Li <me@lirui.org>

Reviewed-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,

> ---
>  .../zh_CN/userspace-api/futex2.rst            | 80 +++++++++++++++++++
>  .../zh_CN/userspace-api/index.rst             |  2 +-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/futex2.rst
> 

-- 
Wu XiangCheng	0x32684A40BCA7AEA7

