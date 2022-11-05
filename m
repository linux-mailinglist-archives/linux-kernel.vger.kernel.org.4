Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6061DBED
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKEQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKEQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 12:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F2DF1B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667664528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUTpwZXcHKBBOGjhf3w1JmuycDZgyHPrZ7gV2/o5GE8=;
        b=PIxI0DQMTTaTkdBXRo8s1nYxpUiR5joyn1L8kpBI8pKri/xrZrboMVYj5tzYvCdFYNeuLC
        GDxMdxyN+092oq35OQpBdrTXCBQhjknpv479cFlZ/enrgnehRaL9RzNs5x2sOJEDGSn/54
        Q+GbW9mm3nbPFZpKioHN4mkoDlXggRQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-DvG0LDXEOlaKHKlF_iy7yA-1; Sat, 05 Nov 2022 12:08:45 -0400
X-MC-Unique: DvG0LDXEOlaKHKlF_iy7yA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C71D1380452A;
        Sat,  5 Nov 2022 16:08:44 +0000 (UTC)
Received: from [10.22.10.76] (unknown [10.22.10.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FFDB492B0E;
        Sat,  5 Nov 2022 16:08:44 +0000 (UTC)
Message-ID: <91c2eaad-92fc-4251-f9e9-7d73cf2b5da5@redhat.com>
Date:   Sat, 5 Nov 2022 12:08:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] virt: sev-guest: Add MODULE_ALIAS
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com
References: <ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com>
 <Y2V7w6PCUV/IxLBl@zn.tnic>
Content-Language: en-US
From:   Cole Robinson <crobinso@redhat.com>
In-Reply-To: <Y2V7w6PCUV/IxLBl@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 4:53 PM, Borislav Petkov wrote:
> On Fri, Nov 04, 2022 at 04:42:45PM -0400, Cole Robinson wrote:
>> This fixes driver autoloading
> 
> What is the scenario where this needs to be autoloaded?
> 

Any use case that needs /dev/sev-guest, I guess. Saves software from
having to do the modprobe manually. For example, nothing I can find in
https://github.com/AMDESE/sev-guest loads the driver, it expects
/dev/sev-guest to be there already

Mostly I assumed lack of autoloading was an oversight. Was it
intentionally omitted?

Thanks,
Cole

