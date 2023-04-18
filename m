Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104E6E576F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDRCTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDRCTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:19:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D32112C;
        Mon, 17 Apr 2023 19:19:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5312bd4fso7056626b3a.0;
        Mon, 17 Apr 2023 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681784391; x=1684376391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjj56tEMHykNAp+oS24dnLfDKAnKTyWKgv6cy2vr5wY=;
        b=GXVS89lNTQHBShGn+sCZBzjxtIoeGXVkDe3d7wwjZuwfdT2b1nZXGIpGxFjG1Ohw4l
         NBjjAdeoA75jMdDGC49ovsgRZEKbFK0npZ9J991+RLSPyG1LM9h93V8N6dfAGPun5sxE
         4ozc37T7F2XM3xfrTdmY4eJqOyjYm+JP0Pszf4d4ETu2rFWzlS3ahrYCWZN6GNuwwhnL
         M5mkWLBpWq5YqKYg705tjJbrO+/L+ciKIBm/ERmrBuNzvHDNg/GajzQupQqsctGBWb5r
         HDXbBLWuAThw4BEQHZ92866sm5B2k0IqKuKPB63jpy8QneknhsNcyL8if5gXYCvsSRV4
         l+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681784391; x=1684376391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjj56tEMHykNAp+oS24dnLfDKAnKTyWKgv6cy2vr5wY=;
        b=g0dk507+7DMCGUrGfwldiwV83Gqzoa3LmmH+tNWFGHZAhUft8u40NipFt2EtfiR/em
         mruYBC+g4gKMmvShD5VmQu85ZUQU12WCaGW6mA7Do1fIRwg6K7Ii1Ua24FPKel3lYtJj
         RUUx4Ub7EMnRbwYDXWNFu/a3PxS6Y61Cl7beeeKegzNfIDnKBRpD6+IN/mX8WStWZmTG
         kE4U45xg0tH1vTFhRn96HWga67AMU+prUV0PQHQnuD4ZvLQ4cPeXqK2M1GpEnvKgzJzu
         uj05GWB2KU89aceIKuRNmVTDZM7PnMmXsrPdGTi0XPmyqJeBWF/3/NtEUHxquPWInG2s
         QJ6w==
X-Gm-Message-State: AAQBX9cPoEqYiVObMqxGQ5g8Z4zxUVRS2RQhYQk+6Y8pcplUqZ2cfS35
        zcBWH0aMlSrEaqpL2OR4ZTI=
X-Google-Smtp-Source: AKy350ZfonQJF00xROCi41foA6j4305I4EHVz+N8kBAbt7Nk+RMFf6+Zp5EvHOScTXw88gOLJu44/A==
X-Received: by 2002:a17:90b:87:b0:246:57ba:ab28 with SMTP id bb7-20020a17090b008700b0024657baab28mr644067pjb.2.1681784390824;
        Mon, 17 Apr 2023 19:19:50 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-15.three.co.id. [180.214.233.15])
        by smtp.gmail.com with ESMTPSA id gl13-20020a17090b120d00b0024781f5e8besm3067601pjb.26.2023.04.17.19.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 19:19:50 -0700 (PDT)
Message-ID: <ce1dcea0-748a-878c-cb2b-3730690004a4@gmail.com>
Date:   Tue, 18 Apr 2023 09:19:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2.1 2/2] x86/Documentation: Add documentation about
 cluster
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org, oleksandr@natalenko.name
References: <20230413172918.1500-3-kprateek.nayak@amd.com>
 <20230414031743.875-1-kprateek.nayak@amd.com>
 <cf4fdb30-6f2e-ca3e-fbc0-b48f6949508d@gmail.com>
 <7b068fc1-2d88-27c3-b561-0a6c36c589da@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <7b068fc1-2d88-27c3-b561-0a6c36c589da@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 07:23, Dave Hansen wrote:
> On 4/14/23 19:24, Bagas Sanjaya wrote:
>> On 4/14/23 10:17, K Prateek Nayak wrote:
>>> +  - cluster_id:
>>> +
>>> +    A per-CPU variable containing:
>>> +
>>> +      - Upper bits extracted from the APIC ID.  CPUs which have the same value
>>> +        in these bits share an L2 and have the same cluster_id.
>>> +
>>> +        CPUs for which cluster information is unavailable will show 65535
>>> +        (BAD_APICID) as the cluster_id.
>> "... return cluster_id of 65535 (BAD_APICID)."
> 
> Bagas, this is talking about a per-cpu variable.  Variables don't
> "return" things, functions do.
> 

Oops, I don't see that!

> I also have a request: I'd really appreciate if you could avoid
> reviewing x86-related documentation.  The review comments that I've seen
> coming from you have not helped x86 documentation.  They've hurt the
> patches more than they have helped.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

