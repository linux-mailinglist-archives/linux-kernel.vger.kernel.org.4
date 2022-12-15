Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A5D64DA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiLOLiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLOLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:37:48 -0500
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 03:36:17 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E82EF26;
        Thu, 15 Dec 2022 03:36:16 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MY60L-1pQWl52yyL-00YPIy; Thu, 15 Dec 2022 12:30:34 +0100
Message-ID: <5c963fd9-97c9-d513-a8ae-5d3f22ef57cc@i2se.com>
Date:   Thu, 15 Dec 2022 12:30:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/7] staging: vc04_services: Drop VCHIQ_ERROR usage
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221215065853.34477-1-umang.jain@ideasonboard.com>
 <20221215065853.34477-4-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221215065853.34477-4-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bGkgykONBpPpX1R6OdAO5MPBl5f1JNTz1nwaYLWn+4fGLciBgMJ
 /VWt6LyeTaZqwsut1MJb45AMkanBWgqGCiXI3rLFdZ06TpnQioP008UhAdv4WGxsE6/MwuU
 7vjMPdFST0lsoaPLMalwQhij3wl9/IC/qHO/f4DJ29jUJZflQfzwq57FkCZSIG9DR7qEA6p
 X4HebJUgEyzx5ogRYFstw==
UI-OutboundReport: notjunk:1;M01:P0:JzvnbawC/y0=;UBeFh/McymgWzME8tQ8tjuJ9PJY
 dijUc02+A3kmFtam9pD+LZHyFGRBv+OHnSvwy4mW/tPoYiU+WGAKgMgxBp3IKGRpPpmdPR4pK
 vBMMyXmDcAXuDdCZUxp3P7+84Z1eoxqeWhn7YKszLD4QDzoo+B5OSppb3sQ+G42O97mJUAJPd
 /GBZdJ86DWugh3L6KW2JBPxfGrk29zcHi7oEeDKnXA/38dVdkhV7cnOBWJw79N6PvHJnRTvnB
 Q9O8aiwApNTui0S4ELbxbBlyMCXOPMqt+zPi3rtiiwTgUr7eOhNB9whDDpu0SbMlm8UUFVGTh
 KNOwjZZfyE8RMGX5rNeR8V2OYC2ga90r8WLSy6p+3bulp0y5dMoQxiDY/DCkSlzjCswFfFTAA
 E1rOrbi4BGPDsYTww4VpKNT4khSJWTNdNmbzt9eO+F0/7+siCEB4ArS+IK/cK+Xs9W77PYzLf
 x3yiQty8zfb1NoSCJIouEUBY3a3eJMrWiQDvONuFV0UrA7XffuSuA25zApMCQVKcXEY+os8DP
 qm70iHgVYB4eXmVUkQrH+/koWiTh/WRCBxm738wUd14andoMeUfIVfQyGzjUnBMuZ33P68IJ0
 8gRzIlo/11IEbB6xPN5WaLJduhRnv2xk9/F1V6/q/fxgpn8dH3AbUosNEYHpNkdiaVf2JahL2
 4Xl6NOY/akCvOGPhYTLDZYU5MBJUr8tKK1TqYkTpfQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

thanks for taking care of this.

Am 15.12.22 um 07:58 schrieb Umang Jain:
> Drop the usage of VCHIQ_ERROR vchiq_status enum type. Replace it with
> -EINVAL to report the error.

I would prefer to use adequate error codes like ENOMEM and so on. I 
agree simply replacing all VCHIQ_ERROR with -EINVAL is easier, but 
wasn't the real intention of the TODO item.

The rest of the series looks good to me.

Best regards

