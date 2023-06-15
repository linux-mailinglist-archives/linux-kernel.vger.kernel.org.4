Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54344731E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFOQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFOQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7022D5E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686848229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9S737sQ9sRxq82uGyw1/zuVwz0loLEFQPA2DfYVo7to=;
        b=aG1ULE+h4z5+N45VS7bYhOr0sXZqJxd6yJCq8vFkX5DyunvdX8DyG5r8oQhtSFpn8S0iVK
        jHSl9PaQVNXme+eW/0+NcTy7qoagHYBlF7stV//REWpyjndHp+S4Cq7aQZ6WMZTJtgXHJA
        Do5V9efU0pbNI07D+BSt2S2zYBVSe94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-TarU5R_NO1qrzhorSc7J0A-1; Thu, 15 Jun 2023 12:57:07 -0400
X-MC-Unique: TarU5R_NO1qrzhorSc7J0A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40D25811E78;
        Thu, 15 Jun 2023 16:57:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id E571348FB01;
        Thu, 15 Jun 2023 16:57:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 15 Jun 2023 18:56:40 +0200 (CEST)
Date:   Thu, 15 Jun 2023 18:56:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        srikar@linux.vnet.ibm.com
Subject: Re: [PATCH] csky: uprobes: Restore thread.trap_no
Message-ID: <20230615165636.GA3886@redhat.com>
References: <20230424152815.GA32615@redhat.com>
 <93544487-4015-f89f-44cd-754670c354e5@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93544487-4015-f89f-44cd-754670c354e5@loongson.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

I think you should ask arch/csky maintainers ;)

On 06/15, Tiezhu Yang wrote:
>
> ping, what is the status of this patch which has been received Acked-by:
>
> https://lore.kernel.org/linux-csky/1682213987-3708-1-git-send-email-yangtiezhu@loongson.cn/
>
> Thanks,
> Tiezhu
>

