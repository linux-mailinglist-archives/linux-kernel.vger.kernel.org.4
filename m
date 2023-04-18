Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94816E5776
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjDRCW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDRCWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:22:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A671BE9;
        Mon, 17 Apr 2023 19:22:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b509fe13eso1190676b3a.1;
        Mon, 17 Apr 2023 19:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681784573; x=1684376573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yprd3wHAL9rLkpnLmwunLZWQV7uHj4StKSCiF+CISUI=;
        b=UpnRjH5GM7n6wXfS4e+jdphe+IgyYBocIg2wHw3bBNJMs5xoaMLx/iUT++WtIYi8Vc
         VfALrF5LkQg4kimliOWEFJ0Mp/r+BbvgaVfkPCbtp5fCAFZvWEeJFI6kazGBLZHenueR
         al5JS0pKrLi+8yu37Lc7FQvW2qAfR3nGt7mVGyMjH97+WZrxCEYd39ZXP/b/zlfgAdW9
         PJaPhOxeKj9BZbDrCpt7CqJAt51Or2WDST5RnVzKQN/feJ2YsFuJHH/GeGLhB86xxPkx
         p5nOSBhVPU6lgP/InH/mTwk2/Kc7BR7bJ4p/bxS6hdPVDYO4mrYnPsH7T0DPP7POrXwl
         KFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681784573; x=1684376573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yprd3wHAL9rLkpnLmwunLZWQV7uHj4StKSCiF+CISUI=;
        b=SgRj8Zm1Gd6kAYiJ2oEOEyw74m5cbYh5Jldrp/zndP/4dqQnd2rNyGWmJh0W+dzHtl
         mOduBc1iX1h4YfLtUswJeyxBxoPoz6lBlqgptG/UOSNgoyHAuru4hogeAsC4WQPTQhZW
         SzbuGmy9nunfc7F62dswYEsiKW23tLIJ/MFnnX978+TjV5HPvoZpcOBphL1Rl3kZOIKf
         8yjpkTNJ8dD7AmdESAov6kuzn2UI1DQILIREJWDeOIZNfdlptaDGFw6hRBkqh+bB6Y6j
         xNTOVhaMiB3P+Dbfe1JB3wY6V1flbh/+L/1HSH3M3fe3gHnifmKBOArkM7MwgL5dmBRI
         HzIg==
X-Gm-Message-State: AAQBX9dhTFO4UPwXF0xftAHrBACp/wvPjCJm+wpyciJHfJUBe2lPJB1Y
        rBzrawjWWkVR7r1gGMWqDvw=
X-Google-Smtp-Source: AKy350aQlbEDlcj2/dsD25/yldbDcPYJ+Za5day4TYq1AuYfiNOpciBkiHMJPtjs8NsDp6sBdsfqLQ==
X-Received: by 2002:a05:6a00:2e0b:b0:63d:38dd:b120 with SMTP id fc11-20020a056a002e0b00b0063d38ddb120mr911528pfb.22.1681784573387;
        Mon, 17 Apr 2023 19:22:53 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-15.three.co.id. [180.214.233.15])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79195000000b00628e9871c24sm8137251pfa.183.2023.04.17.19.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 19:22:52 -0700 (PDT)
Message-ID: <a608d2f3-e498-8253-a58f-7be0e4d832d8@gmail.com>
Date:   Tue, 18 Apr 2023 09:22:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 6/7] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
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

On 4/18/23 06:34, Babu Moger wrote:
> +"ctrl_hw_id":
> +	Available only with debug option. On x86, reading this file shows
> +	the Class of Service (CLOS) id which acts as a resource control
> +	tag on which the resources can be throttled. Kernel assigns a new
> +	CLOSID a control group is created depending on the available
> +	CLOSIDs. Multiple cores(or threads) or processes can share a
> +	same CLOSID in a resctrl group.
> +
> <snipped>...
> +"mon_hw_id":
> +	Available only with debug option. On x86, reading this file shows
> +	the Resource Monitoring ID (RMID) for monitoring the resource
> +	utilization. Monitoring is performed by tagging each core (or
> +	thread) or process via a RMID. Kernel assigns a new RMID when
> +	a group is created depending on the available RMIDs. Multiple
> +	cores (or threads) or processes can share a same RMID in a
> +	resctrl group.
> +

Is CONFIG_DEBUG=y required?

-- 
An old man doll... just what I always wanted! - Clara

