Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D482719EDA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjFANvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjFANvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:51:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B719A;
        Thu,  1 Jun 2023 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685627501; x=1686232301; i=rwarsow@gmx.de;
 bh=qdt3zIQljNt9e8T6xnjmFvcTLHpoJzo70fKVHVhfYw8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=TVZ/qmFjSWfoTtqT5OsIGOc0LEbtvCnLkSaC7JgTJFHGYnnyA7yHw2AtucDIjuMQoYrW/0H
 gvZnwoovWpzTrI7WuWkP7t3KJWv08P8dj+i6cH4ROJzU03IV6Rd50dm63/IQYpZkChVZZsTjX
 Z+9vdj8mbkGfGU4GSrrTs+NKSKviODmy3qRUgXbbspZiuZo7/myeSeYk6ML0DoPNP7skBgydB
 jq6G8QYtL9htu/9rpy4uXjE347qq3AofXh96gK0KsBIbOfIOlHUKiJQOwuwW1ZqOS27uwpTAr
 g1VLnTBoXGS25Z5KkV/Terq2iYfhhicU9V/RNjuSxSYS4e1XwXTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([94.134.13.125]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1pmNXs1VO9-00LBBM; Thu, 01
 Jun 2023 15:51:41 +0200
Message-ID: <24e1f34e-8d35-ef58-bb21-7e8787f010e8@gmx.de>
Date:   Thu, 1 Jun 2023 15:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:l3Z6RUIpo62wKhlp5unJ+1gzU6XaNhUTBdBBTzNSou67n3cnoym
 ClhDEv0mJpAAtmiQVGRQEkp6JSlyrJOQah7BpPz42mywSo/rpOF3eIW4L7qTkPKiOGOQND/
 H+skWLOGMvxwOPEefRcabHRDtPDl4EMzdAI6n2IE4xsbPFghbxwzYoGAe06zfUDCmuZiWaz
 iC+SsESaKXfQI8nqyF5pQ==
UI-OutboundReport: notjunk:1;M01:P0:lW2wuyrV31Y=;bO9iLFkeDElVS33U4qTm94cD9SI
 zO9EXYWciJPyiJvLdIP4NPSZ5PKWCEVpLgefwPqsrOMR0oSa3m1FVoNoSVpB/v9jAlv38pyT1
 BKu5hGdLq0+tMQX7wtjeC4KtrdZRVPerZOcy6rUTaCoWwOp7kFSrx1WxZZO7a0DngIemYJOoB
 SpXavCeNcIgKpiBgBjVHlzKsMAQZy7PYC2Bhmrd6pzxWw6zeEABLtzKeQ300kEZoLbkzFuDK5
 tdA1QeCGkKsOqF7fH8QTRFsZ4/p82oRx67H0YIpAHWHaKaEsdYVRsML5Tzx9ozY7rcHEalYlS
 X4c+llhjhjpXuuFG6LgkCTzt4BoqwQyVvBwLAf225d9WafR0xEPA5ZQcJBEZp5er4ekZR9joB
 3HFDbUkY1R4fASg67jA8PvjEP8JARm56SDieCpeIcXVBapzqrN5zLbkBmEpX4L13Nf2TEAWr6
 s37FIV36N7BgnfkasY1HucO5xCop7N7W2MfmBnDzOZaNStF0E2XzSzPtfLEknsXUJhGPKU4a5
 Y2wRrzzQl0Op+HTpOyUTnehti35k9dv+zUJZFD8fVyyi7+pEZVzxXnU0r1SD49Co6hQoiGmfR
 85tbM6yXKQnnhT0M5rA5ia6LDS2XI57+xqkfZIF3fkitCUfGASTuD9ZsdtCzCGhXzAbzwdina
 5uqr6uUq+B6OlsJM9c89BB0BXJBpH5wp8iRcFM6tCJ4uAW6ExtJsrGWJMT0E1oQYYWsX/lPc1
 7NXfBgUhypBeG0erdxZx4a9JQwK1FbOrQM59B09wmWgIMAYW4yeD39Sc6dscc0ep+khpNdzSV
 mwAp1z7QwB2UxoVQxabl7DNG5oPizoBw2lReQIOLi+ZJ4+Ji3cYwReM2TZqX6iEwdKfWcf8ic
 JUL8NG+/DwEJxxk8w1+RPDVda47EERRUxAeQlmeJSQr6GZSB1+tKkcB8RyykyV7brrvUGMZl1
 l+P2Yg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.6-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

