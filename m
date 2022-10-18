Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C66027C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJRJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiJRJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:00:41 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747FAA6C1D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:00:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y72so14898766oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+56dTD/8cT5IfVvyasJwmIdp2twkCvx6msURbR8+es=;
        b=BJ5Mtg77vy2RCI/I0S5/pUvavbtY9TQevILRWPDF4d+wtdZ0dtySFq/is7++FzUOTj
         SKUt5C94T/JF0MFD/oU1c45bI5KWHsVGznA6pm/iaKR+/uSdvdF+U/yfAyePgg4EC18u
         3Aj5EcEoTM69VGRSBxhgKXRzzOHAFKH9zxKXI2kW6IkZcQaAiE1yxHiMj6RkSc+HLxjO
         4SCB9uIjktgxe+UFa75Ovuy3h9wImF78VNVDmM8rF54NJfZm/8l2pQ1Aon04A6Rq//fW
         59SmTUCCnxS/j4FZMvKnfKl5Eetqeo/90HwQgvZKe8cW/+zukT7bVrg6BjmNjp4IyhBf
         xhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+56dTD/8cT5IfVvyasJwmIdp2twkCvx6msURbR8+es=;
        b=xsbXgRnVx4tfK9NCIbuPMBJN0fF8jwMiJg6esh6oCDN/GxE0cbnqTzL+8oQT42OqQu
         vmt9cLC/MZECRzu3lR6opbreXZDIJo506aFj3pIDMcry64weH1Lvk9kEbc4WF6d8XUv4
         hmCnBVYECAFZso/GZiYO940FcXbI09bHi29rWOSfY9cG1gNP7PpS4Rhc03ed5O/1eb2b
         0e3CvVUexn+uxQhRUgHGNPYPBk05DzMpakFZiAOvkz0XUr7oTQWhdzD1EGpCdViYDXL9
         aHProE+MM0Cjky4nNep+T92OX/3oVONm4uHT+QdHauxMRu+amWYWU6IMCFlOuP1EJFjQ
         L/gA==
X-Gm-Message-State: ACrzQf1joBBH2sugPvXKxKwETjY3ep7GEfuFGaAH9vRW2gEfqEIs0oxV
        bxmfohLl0k25vzzSSDLABlRM+lR49dU=
X-Google-Smtp-Source: AMsMyM5nTFXOHtUrp/JRn7GesABoGAzRksLmNUAKPo7RyGZNVfYZ7SOpD4Ts2KhzHMbwHolUvuGm2A==
X-Received: by 2002:a17:90b:390c:b0:20d:a662:dac2 with SMTP id ob12-20020a17090b390c00b0020da662dac2mr30666114pjb.5.1666083627341;
        Tue, 18 Oct 2022 02:00:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b0017b224969d6sm8258480plk.76.2022.10.18.02.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:00:26 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
Subject: Re:[PATCH v3 0/5] ksm: support tracking KSM-placed zero-pages
Date:   Tue, 18 Oct 2022 09:00:22 +0000
Message-Id: <20221018090022.373574-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017165541.6e2d3cebdc1ba13861ea4b2b@linux-foundation.org>
References: <20221017165541.6e2d3cebdc1ba13861ea4b2b@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> From: xu xin <xu.xin16@zte.com.cn>
>> 
>> use_zero_pages is good, not just because of cache colouring as described
>> in doc, but also because use_zero_pages can accelerate merging empty pages
>> when there are plenty of empty pages (full of zeros) as the time of
>> page-by-page comparisons (unstable_tree_search_insert) is saved.
>> 
>> But there is something to improve, that is, when enabling use_zero_pages,
>> all empty pages will be merged with kernel zero pages instead of with each
>> other as use_zero_pages is disabled, and then these zero-pages are no longer
>> managed and monitor by KSM, which leads to two issues at least:
>
>Sorry, but I'm struggling to understand what real value this patchset
>offers.
>
>> 1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
>>    unshare the shared zeropage as placed by KSM (which is against the 
>>    MADV_UNMERGEABLE documentation at least); see the link:
>>    https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/
>
>Is that causing users any real-world problem?  If not, just change the
>documentation?
>
>> 2) we cannot know how many pages are zero pages placed by KSM when
>>    enabling use_zero_pages, which leads to KSM not being transparent
>>    with all actual merged pages by KSM.
>
>Why is this a problem?
>
>A full description of the real-world end-user operational benefits of
>these changes would help, please.
>

The core idea of this patch set is to enable users to perceive the number of any
pages merged by KSM, regardless of whether use_zero_page switch has been turned
on, so that users can know how much free memory increase is really due to their
madvise(MERGEABLE) actions. The motivation for me to do this is that when I do
an application optimization of KSM on embedded Linux for 5G platform, I find
that ksm_merging_pages of some process becomes very small(but used to be large),
which led me to think that there was any problem with the application KSM-madvise
strategy, but in fact, it was only because use_zero_pages is on.
