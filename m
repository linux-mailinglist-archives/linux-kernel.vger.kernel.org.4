Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FE742E42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF2U06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjF2U04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:26:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99062134;
        Thu, 29 Jun 2023 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688070410; x=1688675210; i=rwarsow@gmx.de;
 bh=CiL9J12qxOBUwf6qGkjvihfgMOUph9VndZwiTtNAWYg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=sm0xAt9XodyAMOBtRxz0TJ/2YyNPLXbZSZ0BAF79yo/5ViLV/uICc6K0ZEWdMKu5pWMHsZT
 lqyIRk6qdweL3YbBFL6/DkX+Wg7DftBM3d8rxLmQtPtobCsaenvFJjV1h6euRNF9ZO8Rw/kMp
 UqN6w68aEBW5EjZ85/r5tYERvQ9CxaI60Zq/5xDGomzOfbiuFMWddhMOiFyUzMlh30izG2Rl6
 w5pRjciRG+ZwvQipXHY6rr1YVcNhjZcmfoHKAuficAocPwe0QNv/ZzLeSz1gipGaFVumVdNK3
 4maZKLFOOMNQT4PaZ1tvzK+Rb2jdw6DSgti1gLHCjDIj0XfpsYbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.89]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1pvnJf09yP-00sJyU; Thu, 29
 Jun 2023 22:26:50 +0200
Message-ID: <99c95822-6f4a-feec-b0a0-f8c5dc1022db@gmx.de>
Date:   Thu, 29 Jun 2023 22:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/WnyCb4hLfRPjkKu+SP5zsovDro9uaPi+5KRHENKvUPpKQULqnh
 coaaAHfzxW0TjhQxYHjgMk+LiJTZUZ6hhcl5JjZNoP0mHfgQPTi3HK7GdE1HoSsBPrnbB1o
 pTCbLD8E53Npyb/umMVxkTpuHl/POrOMXzge1zTJY/wohS9zKWhnazmNhkPxy22XYPfanxE
 OHjFosc+Rlu/S2nyF5p6Q==
UI-OutboundReport: notjunk:1;M01:P0:0fa3S42ZzSA=;f6nv4iMIu80syZvRne8ArnHUNPL
 HdC+x5hZxNlkS1U8pe7mREKLX6pEXhRwTb21mM/qn36tX0WwFHWLYy0cndthFIWTJuXtCuNB6
 AOiCcSb/cBKzq3Xf/1j9CBdOrXDOKOahc2536M/bWF9onUQr0xL340CYxnB+TWw+VfaAxciL1
 tlKfKJET+ogeiBDAun+i8XDInpg46C49ldoYCZ+z30fnj5Kn7p1/aadhDotQEDcwCo5VK0QBL
 88Tl2TfEE9vRTwplNiOmEThmb0vh2ftK7aaarmXA4T90HeShsG78lsaQxP8DQjtgdyc3Yq9OT
 V07YhjwHmFUE8bz3ug69pjdJfdLGI1PdfxZODbWPGOARgxR5/gNnGhcQSdXCEP3MRmbxk6ypg
 nNUEdhO0c614YiFMeYPc+Qk6n1N8WZfusb01KXPHYKU+ttdNBJY8hVWLNh4ySGLlfaOkRrDhX
 MBajJm407+KtMXIip+rxCrXb82SAxk8Qj7gaNCr0SeTzp4BFEkllP6H8XvoF32kg8/3+yVlvT
 tjXAaVjDDrefvU4HZnZy91vhVhGKjrLj7Dx+de3VMMq5SvPttr+axunVSnCngMPSNf1EhVVfa
 FicKAdmO075fUuiI5TOO9O1jshmPSfA3r4ldc4Y0y0lT7M0tX3ue/rtkZKzCjrxWefU5SPyy8
 NxmKBHYlKNuQz+yMbgfmj22UBLpMKCy2bLch4OScIDkDZOGIDuNsZxYdETO4yLbPOAr9RdGmD
 RGKOexSst/ZLF7hLw5jWr+KsOpvAr2jSyeJjNDaP1hKThMdoNqDThK9hPcHRlTfgxOQlLFHi4
 tWTzfcSc56S14oBETS2Vv7fAsWH8I04NIfuqrtHBHQnklh6Py+pkNXJeV35mzUpVmBHwq9Idf
 Lpk0V+5CYv2E+/n1DdE/xza3uqVQtaYCFtUXQMvsLgqxB/jObuCeoOja3hgSlKbZ4Eo65mqTz
 /yK6OaaacgNbG4jkbyNr5Y8TQqA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.1-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

