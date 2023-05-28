Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88311713FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjE1UC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 16:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjE1UCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 16:02:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421D1A8;
        Sun, 28 May 2023 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685304141; x=1685908941; i=rwarsow@gmx.de;
 bh=AnNuo72Dy47T/QnE44EUI9tKC9Zk9Y9YDxgT07bWbeM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=t2SmhfuAGIXgw8OjQJszEzwj5ELWa5wCBNTU/VrZELhI5fyhC0XR492IahYkTyiLXy+yLEz
 m6AOaLZHlTtL/G748ItEoNizkP+7dxOU/CFIqAwcHkPndYLKdWMXD/mej/vublTCnPU1W8XsY
 DLEYObt6a0Pdcn6N4Uwj9wkSABxyZ12eVhaJ0X1R/TLYOhTInedb9S/ERKvf6wVWRurJHiImm
 IIPCsNWXdZ+zJKr5My2ezZmDbV3PIUu7I1cOw2yqfNyY/J2wcX/+X1GPcu+87BITksy7qsbKK
 qtkvkxRb+1b0xwS2g0mPOEQEKnIIVbXepr5Q5MSP6RLtGtOI2zpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.217]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1pwBb50ErS-00BdgL; Sun, 28
 May 2023 22:02:21 +0200
Message-ID: <54124c02-325a-068e-7b76-2d6787a8cf96@gmx.de>
Date:   Sun, 28 May 2023 22:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/127] 6.3.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OhCMHlOuDxHRLqH7y0EIrH/IaMkXQW3sqZdP56ISO+lFNZW/CKI
 vwesFkmILbq30Gp/jFA8zF8Z+Ps0Zzlqy66CtezFqfjljGtJVn5zUhoOn8irevIn/UPB4Ca
 rSSDLi35g+7+WPUfo+fM5cHYO0XaNAmm8JFYvwz3p02x5gdZ2LofLYN9n3cHhOAM4nBS0nl
 BfuTc+J7yDb96D/UbPGkg==
UI-OutboundReport: notjunk:1;M01:P0:BNJ9AWtHDL0=;9i+5NaD+PwPb7jELtNl7HMGVIQn
 kd2PC+gNAKLJS2BV3iobMb6xOSoRrkEKW7MCuJfIRE7Z3Al2PnnWGxG5xq2i4LqP9cVrBdW2b
 t80prFY9tUmZ5V72h5pJXrZjSjFLrpTq+6/asuC+7uSAAaujpW115BPy/xiUiDnlm7So1mYcG
 VGSbyuxArUD/nCZB0v3JhqS4mFwhkojOvBUrLRa+aKnVh/ozrqZVv6Yl/pp/zGTCmnTIkwUzY
 F6ou/WpmxYSrdOv7S3tVueV3odcUuAUznsKqKORmUeCFabhpxQCYXi43n8lXopGcMvgPPuVhp
 eJb1jwLBoz34yhSqAtYV/g3Wu87DNtDsDGwPO0FN3jAzGYUJV2krYybayuIjwCl67NJcIqfqO
 TyVrhIzze6rCJFRAeMsV9D122+88RMgzjABUb978kXP7v7Szhw3whzwDzrv0eSl3+O5c5DsCR
 ImY0ha7mg8NpT/0cEmz4yU46h2HLpVjlQ5ONe/F+Q2clJgSdx5btk+ym2D+ZhOZX4qqTgDMEZ
 d93ZrO3r862NC+YtMgSW68ScnL0cxW+BrL/M4FqEHn2+94/gR9ionLc0nmH0EixkmAcMgLFKS
 /Wl+3M5dmSTO0djG/XHtLU05zwZC0TPTPnotWzPHDZnWWnJQoABkNiUBqnT/POh/M192kTdfG
 YelvTDz5OA9Z6sFZ3C2SKSJO3xEtGj4ZDRtcWAzr0iHf1CiItmF6OQkQhunsxGzfa0VIxlKU3
 1KEPBulTfq9PC1hN3R9eoF0dl63chfgVkoaV8+H54i/2sJ2sl6oZRI5tAERYu3we8Ysewu90d
 aXJuqJU3CbDDVhRbJuU8iOpkIlRV6Amp2+xwk+fcyQU+HNCIbGzOmPQA/Y2N1u80j3rj0YhcK
 KqvnKWpQP7+uMqnqblrWMsKelb1YFmAJu5rdaxCxymXRmtOo9FOp+iCT8u6YC6qi5h2pXkvjI
 qUGgg8J3DuioZ+ggKzszwcwDAXY=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

6.3.5-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

