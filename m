Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7E5F8312
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJHFOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJHFOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:14:16 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E68B282;
        Fri,  7 Oct 2022 22:14:13 -0700 (PDT)
Date:   Sat, 8 Oct 2022 13:13:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665206051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vc2U3Kve2XhOvrPk6EOsiW40rvA4chvu6C1WjVQRXVU=;
        b=LH0KkydAnUjcj/4zKY0JZG6OBKymdrt9HYFx23i18WeUWSm8WhV773uc+T/msWSm8lUp31
        CONkXJpXHlAC89M72h/U5Vy52jKEzdDPoWOQoSJTdvQSwXf4r1fYomVTJW0wECgtCRimbc
        6nT8p09JK3D0aDC33YHCmX6LrLhgi7s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        chenhuacai@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] docs/zh_CN: Rewrite the zh_CN/index.rst
Message-ID: <Y0EHBw9C1UpVA49k@bobwxc.mipc>
References: <cover.1664945550.git.bobwxc@email.cn>
 <6afa9f74-8c92-4246-17e7-c40bdd622639@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6afa9f74-8c92-4246-17e7-c40bdd622639@loongson.cn>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-10-08 (六) 12:11:06 +0800 Yanteng Si 曰：
> 
> On 10/5/22 13:13, Wu XiangCheng wrote:
> > Follow Jonathan's steps[1], rewrite the entry point of kernel's Chinese
> > translation documentation.
> > 
> > Thanks,
> > 
> > [1]: https://lore.kernel.org/linux-doc/20220927160559.97154-1-corbet@lwn.net/T
> > 
> > Wu XiangCheng (4):
> >    docs/zh_CN: promote the title of zh_CN/process/index.rst
> >    docs/zh_CN: add zh_CN/arch.rst
> >    docs/zh_CN: Rewrite the Chinsese translation front page
> >    docs/zh_CN: add a man-pages link to zh_CN/index.rst
> 
> When I apply your patch set, Git says:
> 
> 
> Applying: docs/zh_CN: promote the title of zh_CN/process/index.rst
> Applying: docs/zh_CN: add zh_CN/arch.rst
> .git/rebase-apply/patch:41: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: docs/zh_CN: Rewrite the Chinsese translation front page
> Applying: docs/zh_CN: add a man-pages link to zh_CN/index.rst
> 

OK. Will be fixed in v2.

Thanks,

-- 
Wu XiangCheng	0x32684A40BCA7AEA7

