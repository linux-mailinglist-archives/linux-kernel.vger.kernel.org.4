Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADD734453
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjFQWCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 18:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQWCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 18:02:30 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605E1737
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 15:02:29 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-777a4c8e8f4so98637039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687039349; x=1689631349;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJf7mco65KOSHvliak4wqtEhSJglYTckL5brhNhFuQs=;
        b=G1DiiroJoOwppVVTaaFHc53HxiRSgDGJW3vZRRPjdudLHdhV8KyuK/LcMdAWiyy69E
         C0n9jDoToDh03oRa8FVVEOZc4K5CA00423EG3Pk7Kvx//vGnOR4y1zetUoAYK9vShiV/
         o/d6Oq+hUKLHgOpcPoSd9ZxRMb7Ul9DwSJ6rh+63yyvRDcMrnjFtrAES/YPQyrQTxEaq
         vc57ivfv3cSQR654XGB+3eRvD2l0WhnFESfJjw3CVeNIij+OZuyKnER3P5TkSSP7Ud8U
         dD8dfBTFlN/nEopEzP3VBF+xgHTFIaj+aZoZ7ZDzjk483OYUu5OD8IlXHPsnK3r5/631
         efzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687039349; x=1689631349;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xJf7mco65KOSHvliak4wqtEhSJglYTckL5brhNhFuQs=;
        b=DDbd31rwyPwh4vJmbnM3tnhDC+7gz8oEiLxy6L8JStqYYiqL25hzZacdS6rb1FfX8G
         V5d0TxyBEDDbmcVDq+ayQSwQYEN0eR5QDf0y40qIImLRQSU3EGJr/tw/NnTrZIx/iga3
         Z5gopj5I82sZYBwSnOYDPwd74ww42rVhvTyQ7i1T5Ls9JZ/jp+OZU84MJ/r5YLiPuLe6
         GB9cFZ6mHBMhX+nmEMgvrEEm3F+cxSf7dhmWBy/nzcEXEJ7ZToY28MQShh0M8M6TUiyT
         E22NfN4G9ZB+QjR9coBsRBmMmO98lVKDDm++2vbvuZeIrWNq5Em8Qj4J+6/rUjnXIo+E
         jYhg==
X-Gm-Message-State: AC+VfDzVXvoEhQREUWNF57V70Eyy+y8O+GqGywHD2q+8AKBXgtQPiRwC
        umRlS6tsheDjmhI/NZUrn2VOmlnaBe0cTA==
X-Google-Smtp-Source: ACHHUZ7jx3Inb+OwjEFy8y6ThjPo8PcqE3Z4xMuBYpiN5AE9CgxXep8EwJW9QCNty7khAlMcs3GpvA==
X-Received: by 2002:a05:6602:424e:b0:775:5f74:f4c7 with SMTP id cc14-20020a056602424e00b007755f74f4c7mr3641810iob.17.1687039349164;
        Sat, 17 Jun 2023 15:02:29 -0700 (PDT)
Received: from [192.168.43.16] ([199.7.157.10])
        by smtp.gmail.com with ESMTPSA id g20-20020a0566380c5400b0041f5a0b7fa1sm7226438jal.144.2023.06.17.15.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 15:02:28 -0700 (PDT)
Message-ID: <77f98dae-815f-2191-0a1d-63e2a0886d9e@gmail.com>
Date:   Sat, 17 Jun 2023 18:02:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
From:   Aravind Ceyardass <aravind.pub@gmail.com>
Subject: reference counting gcc plugin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2nd attempt. I hope this is the right mailing list. :-)

Hello Kernel People,

I have developed a gcc plugin for implementing reference counting. I see that the kernel has implemented many different techniques over the years, but I couldn't find any with compiler support.

I would like your ideas, inputs before I release the plugin for everyone hoping that it would benefit the Linux kernel.

Here is a sample code to give you an idea of usage and the code transformation done by the plugin.


#include "hrcmm.h"
/*
  REFTRACK_STRUCT macro defines the following declarations

  struct foo;
  void foo_addref(const struct foo *const);
  void foo_removeref(const struct foo *const);
  void foo_destroy(struct foo *const);
*/

REFTRACK_STRUCT(foo){
    int bar;
};

/*
  REFTRACK_EPILOG_WITH_DTOR macro calls foo_destroy when reference count is zero.
  This is optional, if there is no special cleanup to be done, use REFTRACK_EPILOG. 
*/
REFTRACK_EPILOG_WITH_DTOR(foo);

// This function is called when the reference count for object pointed to by p is zero
void foo_destroy(struct foo *p){
    if (p)
        printf("foo destroyed:%p\n", p);
}

typedef struct foo foo;

// statements commented out are injected by the plugin
     
void baz(foo *p){
    printf("%d\n", p->bar);
    // foo_removeref(p);
}

int main(int argc, char *argv[]){
    foo *p = rc_malloc(sizeof(foo)); // rc_malloc is a default wrapper provided
    // foo_addref(p); 
    p->bar = 123;
    
    // foo_addref(p); 
    foo *q = p;

    // foo_addref(q); 
    baz(q);

    // foo_removeref(p); 
    // foo_removeref(q); 
}


Aravind

