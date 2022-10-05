Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD115F540F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJELyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJELyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:54:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0592F2733;
        Wed,  5 Oct 2022 04:54:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f11so22948632wrm.6;
        Wed, 05 Oct 2022 04:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCsoKpBjdli7iWIkHe29aBSIVoJwl8PXogMcBODUYio=;
        b=Kg/L3CLDEZ/nyqsQOgq0igi4W4pMphRH+NiO7CgJY4d/sndcCHI9n7AJ4F5clP3MUP
         nj9ZgYxi/0mOofynUPs2SqLciJEf9zMtOxFpN8PeZUIw4S2/dcoqgbsrjjXn3xpcqiZy
         90lfF/Ua7V6ArPVKI0tC6s770FIiER25HS+4T/j4F1j3lYyYODZmraCc2MmLAjuYa/a9
         m5vR9zlaGpynximenCOC6fhki1HW22hRxE9bRvEH+GuyS2zhr0r7RyBoLImL9xv1mGrL
         lAFkVbyRUe4IQ3OGcwYoe29G0vwomRjfyJ7yZm0CVoHGEOer3cMa5cfFmUNkST9w2XbR
         6muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCsoKpBjdli7iWIkHe29aBSIVoJwl8PXogMcBODUYio=;
        b=uQ0fPLnosfsiPCqso8FtuewJsRABg+pCCgOarxIyGCI/+2zbCbFL/RJ50Arbmy1Isy
         f5/3lkYgG0k0lBxUFFNjcgqFr2Fs1c0RnwLjdhRUnkG406A33aY8I0OJiWRJmwwd5wXW
         o0jhDhsTqwSTxCVmbfM99OgwAY1A33TnA+skgGTlT8gRX+GIrEk9AlxsMp+OiziHRpBF
         QiXhxyHABB36wACAyJgzEQ6RgCFRbRbl77kax3AAnwg9BRrq2XRD1oli40E4yLQqCzlv
         707UvTLmznd5fduvr/cVHB1Yv6vOQ4x8xo9TuIXcPfvRWLVjeel0nGC0hnrpz58xU8zJ
         7uYQ==
X-Gm-Message-State: ACrzQf2SuXarxWBDnDCB8jo3vaDBzWa5dRdwmmYLBLGYMZT3SY2GfPcH
        O3OCygvu8hRNLcGp0SsFaZY=
X-Google-Smtp-Source: AMsMyM5WMIt4f5MS393VOv9AjgI6yx4Irw8PmuCsNpz2bHT4wI962SVwH4/z5K+dcs6EdH0TqLNnVQ==
X-Received: by 2002:a5d:4f12:0:b0:22e:3920:a09c with SMTP id c18-20020a5d4f12000000b0022e3920a09cmr9616073wru.95.1664970847532;
        Wed, 05 Oct 2022 04:54:07 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003a2e92edeccsm1806714wmi.46.2022.10.05.04.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:54:07 -0700 (PDT)
Date:   Wed, 5 Oct 2022 12:54:05 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20221005 due to 9dcf746befa7 ("LoongArch: Use
 generic BUG() handler")
Message-ID: <Yz1wXUklaN66j8Lt@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of loongarch allmodconfig have failed to build next-20221005
with error:

./arch/loongarch/include/asm/cmpxchg.h: In function '__cmpxchg':
././include/linux/compiler_types.h:357:45: error: call to '__compiletime_assert_2' declared with attribute error: BUILD_BUG failed
  357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:338:25: note: in definition of macro '__compiletime_assert'
  338 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:357:9: note: in expansion of macro '_compiletime_assert'
  357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./arch/loongarch/include/asm/cmpxchg.h:179:17: note: in expansion of macro 'BUILD_BUG'
  179 |                 BUILD_BUG();
      |                 ^~~~~~~~~


git bisect pointed to 9dcf746befa7 ("LoongArch: Use generic BUG() handler")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
