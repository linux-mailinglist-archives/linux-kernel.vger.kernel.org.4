Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF794720D0A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjFCBlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjFCBlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:41:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9981B6;
        Fri,  2 Jun 2023 18:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IGvHg8ueaPSLkb+HRbdq0Dyuayg75nPra3YsPtVkCzg=; b=1mFtfwrNSoCATUnXEClh2raq2A
        a+OJhHBskgEx566hrqUDJyFNaBAWrMYNt9Gq8lJ/dN4xIqG9HW53zJN47Escx2TCxEQeGhvx7PHwY
        K8FZAyxM/BK9k4n28fNUDbE7f8Jk0sDphxyIiwCjGQJmZFNYcwx8KMWkTWJT/9YaZWxx5hwRL3AYD
        +i+NIs7LfCRHPkYDNpncNsQwX9XUF/pRE2glfMZ8wmTrbCpigkVPZyhpC3hvwY1cp+2Vx6TfNV9De
        OllCRQlPZlnkItQJw+cddq8qMbS9l5MmCH26qXZdYSDV50V/kR5syVySuuIiQsoQhh5rgDLD+v/ZC
        64+E5nlA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q5GH5-008T8b-2K;
        Sat, 03 Jun 2023 01:41:47 +0000
Message-ID: <e69410c1-8632-354e-e6e0-ac16631f0566@infradead.org>
Date:   Fri, 2 Jun 2023 18:41:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] docs: Fix warning:Error in "code-block" directive
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     ivan.orlov0322@gmail.com
References: <20230602215102.GA220958@madhu-kernel>
 <ZHqVbIouMkvM4OAs@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZHqVbIouMkvM4OAs@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/23 18:20, Bagas Sanjaya wrote:
> On Fri, Jun 02, 2023 at 04:51:02PM -0500, Madhumitha Prabakaran wrote:
>> Fix the error in "code-block" directive by providing the
>> argument as "text".
>>
>> <snipped> ...
>>  Result code:
>>  ------------
>>  
>> -.. code-block::
>> +.. code-block:: text
> 
> Nope.
> 
> I don't see error you mention in this patch when making htmldocs on my
> computer (my setup is pretty standard: see
> Documentation/doc-guide/sphinx.rst). This patch is unneccessary, though,
> unless you have code snippets in some language (e.g. C, where passing
> language name to code-block:: syntax-highlight it). Result code outputs,
> on the other hand, are generic text with no definitive syntax, hence
> you can omit language name.
> 
> Thanks.


I also don't see any such warnings so I don't see a need for this patch.
My wild guess is that some older version of Sphinx was being used.

-- 
~Randy
