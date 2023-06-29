Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D0D743100
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF2XUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjF2XUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:20:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7D11F;
        Thu, 29 Jun 2023 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jK2yIsW4r1gDHXlMqYKPZXOCEW8BMnll+kWpXMp/vls=; b=Vo3RBGyRjdpY7V3NsOz8z5hVIH
        hLX5uQ4ws4il38w7vKSpMutyd0oC432Pn4E9mq/Cu8PrMTZbjjAY4PAx+l9DMUjOF+t8BSgY8fzZe
        dm5zsxnaYX4yJr8BuIiGoVpRqgcUzFXSFvCVKNo5hKAn4WueSo22bQkW2Csd+k1Ds+t4PcshENcU+
        eOMFlIsr0MNFVotbg78pscD1DoRTIrdLNykIlfg+2GVXo39lFxbXP6hrYiawM81pyOgFieuvTYEJS
        OM+rgtqhiSwHtU4QcNe3QPxhL0FLvBXA/QWbeAh20oSJD+GNIMILs+fwlIrVu+m9mWcUYbIUvgqJN
        PX4s7WjQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qF0wG-002SBW-16;
        Thu, 29 Jun 2023 23:20:36 +0000
Message-ID: <f907d71b-bd00-5649-d577-bf9f53fc2f83@infradead.org>
Date:   Thu, 29 Jun 2023 16:20:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-7-eric.devolder@oracle.com>
 <c9d4e623-5c8c-885f-4343-980798647a0a@infradead.org>
 <e0f5adf6-4f47-75c7-5697-5e928bee14b7@oracle.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e0f5adf6-4f47-75c7-5697-5e928bee14b7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/23 15:31, Eric DeVolder wrote:
>> Did you test build the documentation?
>> It looks to me like the end-of-table '=' signs line needs 3 more === to be long
>> enough for the text above it.
> 
> Hmm, the 'make htmldocs' renders and views ok. Is there perhaps another method I should use?

No, that's it.
Sorry about the noise.

-- 
~Randy
