Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4B720DB4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 06:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFCEER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 00:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCEEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 00:04:13 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27791E41;
        Fri,  2 Jun 2023 21:04:11 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1a2c85ef3c2so124732fac.0;
        Fri, 02 Jun 2023 21:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685765050; x=1688357050;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDJ4NW+v18hRQd8QqPDqLFxlqAOhHV7cNr8XZuV5p/M=;
        b=LSX7ARdS59+DyGbvCXkuRwOgqNdiKd9etKckiesB61nejVFFs5qd7juAnJxIbhHaRN
         gnWjC4xZ/bEAOmnN9DUWXaZc/pVLzF10a/s4mXae33HepSSjnzKYqSAmVtsh2m/FQTEA
         Am1bupJp1qiwX+EF/j1RYExTuCVjUxxQpwJd74EGo489swZ5ApkGEIfm0w4Ly0Qv01m8
         ARdb/7uLQ5n8VW70R9piC4lfYxjn86c+s/fLGFSX9N6DGT59IOoIVg/P7d+7QW0XROvC
         mD9JzoLyvvJeRocyUVZ1k4jqWdso9cJ1iYH84Sxt0QEfu5jGTqkBUI1vyDfyJKMg79ax
         e+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685765050; x=1688357050;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDJ4NW+v18hRQd8QqPDqLFxlqAOhHV7cNr8XZuV5p/M=;
        b=WipL+BgF2wvxuqtFXi55ml4o03lALAZPlSMYvnuIeVFB7fCdMyEjb6hqkHja3VMKiJ
         Pz2llQf5bphDkcY/JzyrFXZ6f0ocIXb4RlW/o67l725OIvo+iudL34IOZMAY9YOEXVSm
         M23fg15wiStEYahJtswAuu9UDMPPil2vFOqtw/j2ZIvZE7yRuOL74sLS516D7h2SxIMK
         1te1LPsq7irfCsv076qFgw524hFJbaVAD76l5VuDkPCU0MOoKMS43E3tKMCHIMwj+kYY
         VBPYF6C4rIHhEVVmwS6O1JXZnJ8Ws1V5GVbVklmL5s5N0kjEZ9HAJEJ1eq5HgtpFqpxf
         yoGg==
X-Gm-Message-State: AC+VfDxGO9pSEGltUwK86GuX1PUlnOzBxvEaRq3XZJJo3n+JpDWj0LxA
        bZO+K0ICMQI0C/ZFugBgC2I=
X-Google-Smtp-Source: ACHHUZ79T/IdMlsUgPFqgx50GCVquh7X2k1tD/RxI5X6jTrEpBwxfRzrW8lGWHsDXQpHaj+wlD+T8Q==
X-Received: by 2002:a05:6808:186:b0:398:2a35:f328 with SMTP id w6-20020a056808018600b003982a35f328mr2055001oic.8.1685765050391;
        Fri, 02 Jun 2023 21:04:10 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ie3-20020a17090b400300b00255e2d5d56csm1944618pjb.1.2023.06.02.21.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 21:04:10 -0700 (PDT)
Message-ID: <bf0dee59-20ce-27d6-5b6a-683525fc012e@gmail.com>
Date:   Sat, 3 Jun 2023 13:04:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To:     rdunlap@infradead.org
Cc:     bagasdotme@gmail.com, ivan.orlov0322@gmail.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhumithabiw@gmail.com,
        rafael@kernel.org, skhan@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <e69410c1-8632-354e-e6e0-ac16631f0566@infradead.org>
Subject: Re: [PATCH] docs: Fix warning:Error in "code-block" directive
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <e69410c1-8632-354e-e6e0-ac16631f0566@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 18:41:46 -0700, Randy Dunlap wrote:
> On 6/2/23 18:20, Bagas Sanjaya wrote:
>> On Fri, Jun 02, 2023 at 04:51:02PM -0500, Madhumitha Prabakaran wrote:
>>> Fix the error in "code-block" directive by providing the
>>> argument as "text".
>>>
>>> <snipped> ...
>>>  Result code:
>>>  ------------
>>>  
>>> -.. code-block::
>>> +.. code-block:: text
>> 
>> Nope.
>> 
>> I don't see error you mention in this patch when making htmldocs on my
>> computer (my setup is pretty standard: see
>> Documentation/doc-guide/sphinx.rst). This patch is unneccessary, though,
>> unless you have code snippets in some language (e.g. C, where passing
>> language name to code-block:: syntax-highlight it). Result code outputs,
>> on the other hand, are generic text with no definitive syntax, hence
>> you can omit language name.
>> 
>> Thanks.
> 
> 
> I also don't see any such warnings so I don't see a need for this patch.
> My wild guess is that some older version of Sphinx was being used.

Right.

In Sphinx changelog, "Features added" for 2.0.0b1 [1] lists this:

    #1851: Allow to omit an argument for code-block directive. If omitted,
    it follows highlight or highlight_language

[1]: https://www.sphinx-doc.org/en/master/changes.html#id1306

Pre-2.0 Sphinx is now deprecated.
See commit 31abfdda6527 ("docs: Deprecate use of Sphinx < 2.4.x").

        Thanks, Akira    

> 
> -- 
> ~Randy

