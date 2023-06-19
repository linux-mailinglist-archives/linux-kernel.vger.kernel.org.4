Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ED3735AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjFSPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjFSPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:04:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BA26AF;
        Mon, 19 Jun 2023 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687187009; x=1687791809; i=rwarsow@gmx.de;
 bh=hhdxj/Xjt6ZWARd6D3wTAaeKNyhelBmF6mC73vvS9Gk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=EK6aIxFz+/4fgKaCu/bKKerxmEOBZBainQMwan+iJ4pJx+orQ+4PUSbH28ccjXFY4SDg70S
 MsONHHvFPcOXRnW+pp+NbLnm8RYz4m/5YnE+pUWL0Uw7T21l8anB1TTZiZiLiWJtYzOftFI/3
 ZXse0A8ZncvFRqiwXgjVeWIjuILavnLrt/v4o5ncHKmxxAmzDIJVmOVXxMKjdQE9aFkRg/PWf
 w5e0vGRdgs9TaqBjM6+R8Cy1OlGoFxJa1nPyl6V+IAZl005wsLFw9k++7TSo9Uhg31zQtxeEc
 RNOr7y88neSoQwYIvQYVN3A7nCDvnMnZj7q5wxrsEc+6AjdLzHgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.36]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1qLfkd288c-00AVSa; Mon, 19
 Jun 2023 17:03:29 +0200
Message-ID: <c5ee96f9-1f93-3eca-6560-b8367cd8d124@gmx.de>
Date:   Mon, 19 Jun 2023 17:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZQRydHeOsjL+k65rPKB5LoyImqjxiCgWsvKYYNvuvBJI7DZdRwS
 NIMHvaE6JPbDNYua3IYd43Pul+BM5368vEmD1bkmRT83vNh/Zdp9JY9+T+Be+pa6VhJmSIf
 C4k/333TjG0ePmY3+Cw+l49/i/nvjxN7t6tuToLwWhRnV9+4DsZWaQw6UX9jQjWttiRCVWu
 Eixm7Ij2i+wwcoN4/U35A==
UI-OutboundReport: notjunk:1;M01:P0:MWw0k52Rp6g=;C65A7r/Nmw7ZR4REydKCLi9E6dx
 l2EkmuJqlpmcv8IWSVYIGJFhlzkBrdia28sXC0GUR3XNGToN9TDc6n+FoyZpSQb0rLMNfzZGy
 Y9NBuhA2HcTNCls1LVLLPfcdrDQ9xd/osUKJH87goa6LSqC7MxFDMCjhjWnSrOxYQBL/8OtGh
 BAt39vjawz5zu2XVMjeeZsKXDEPTHDOtPwhtoFdSJg4b+xk0aV7dM9uoTpgE00fxso8booQqp
 6RopDzmkKiI/9muzgk2Bk3eQl86uq0coQi4qnphvXwiC/Jltffye0XZ1tgSiKn24BctKXY9nO
 9qWdDrv/uQz16f/BTGkj55U/PaZ0Zee1WBNURYKFaty7yqARaLIDBWdfz1xkwNXilda94tseF
 0Nz04/4FHSa4ijh/mZWJNfdUu38YN1uw2JLAxCj38+rthsxs7ePDmmBBxJ9DDV9wvtbzIt8bc
 RVLmV6Y2ge0nSbNX+2Ncz1sEje7GbMBSCLHitZ1bk2BiwH60k6Bk4LnFpZi2AnP6vYsHNR3yY
 FhtzCCCB0d+xShb0fOLEpy3hdy33rWdxwuGxn3BfAivCD6KPcTPTlmdaKoQu764Ca0OfUR3Vv
 vbRKrXNqIn6n4RghFmaXXgNzpGXu2l9OV1GTRI03/+LepRJ24c/84OP+mHk8n66Rwu8P//S6c
 Oo3iZkcMEmgV9egKj+xSvUL4L5wk3wA/BK6uxUAu0lyzxwGt8p3zo8UX4HFYaSUtFj0UfhZKT
 W4v4Ql5//F1N5TTPli7G7n0UL8kHsoawqcoTmgbXt5W4rnnBbIACAXDyjMrxGq5EnvUNeQGKf
 ia5V21x6tyNuJp+kicJX5doV9EFWpnEsg0jbVo79iHV1AuwZvi/Km9kPV0oZeFg7Axs+NVCwI
 f5KT7VMeQ/VjA2EwjHrP5lQuBfZcHDKorxgSxezBZhtn+7YpOBEu9rBudJEJ+CHx8IGdo/zP2
 kUqCKP4Y5G19xefTYEVKxLb5CzI=
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.9-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

