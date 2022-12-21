Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1398653051
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiLULep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLULeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:34:37 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9772677
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:34:36 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvLi-1pL4Nx2RGq-00Uqh4; Wed, 21 Dec 2022 12:34:13 +0100
Message-ID: <2b9c0f42-94f8-d2b7-6be6-ab699f8114d9@i2se.com>
Date:   Wed, 21 Dec 2022 12:34:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: vchiq_arm: Remove extra struct vchiq_instance
 declaration
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221221074047.233473-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221221074047.233473-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kiBeU43GXecUiKrJ5RXjnkBJvCO8Fs+MA/242np8vA6T412pMmf
 L1MYaAo7E6KuqwaE2mELdly4Pq3wktU/26TOEeAEpIgaEU1/qzzyJgxmxCTdQ4HU/UvKX6e
 KYY1DkiCfP3Mxq5zgsVYJRasiR7LK/Xlge9mQXkVuo0ykBhxn+JqSbbRNZPNZLGTQ9U53bT
 51Uo54OC4Dm9ROMUOmQfQ==
UI-OutboundReport: notjunk:1;M01:P0:e0VFEaORvYc=;tq/kP2HcTpjnLJ5rQF8GXQ51Gdg
 jADPmuoOs/CM2jnqAoNQL0E4B3zwtUTp9NXtnHKcvju8CjffCqfitLEGBe5r0F1WImbe254FB
 B0qCCos7UFaDFCKhC4lY6LraSQsxBuHoYhj3qp9mwEA0SMtZs5gqVSG+6YcVMYjVc0VMNYkDg
 HVTHAOxs1YC+gQpAEqOd+JBE+2k/HJYiWfV078qBQXxPWRBjX33Z+yTCMZR0lpPyKKOu2stJR
 iKLykUm+EvY558nYKTf531bMfqY5HlWtHRDgVSlMfG0l/dy1vc+FOFCq68GN7NvnipfESOMww
 yRRVS8U328KV5y1HHG6+qnjzlfurPeGzjZX72k69TRiMy++J0PUmFwMhxUzJFjEZ5E3boTqex
 Wv9IKBkdVsyYP8wh37EfjwZLqsxd8b8iLRos+JX2uV366nEaGC+ERRIIf6KsnHOxu/8DNzgI2
 mW+y5e1KDQtD9k4zwTz9zbVW8paZ1ynkJi7EXAkPehRZej+kcV24OO93DuuJ/Yu/kL8u2an1o
 xcD1aKFTJ6YRVdnjtExPnF/7ge6kekTdUMEk19s4kTwiW5MHjZW+5EbEYl1kYrbKiFb82DC2f
 AqJQvYkxVDUn6ou3dLZfbht2hMmbwbrnD90+EPWUY01CjdDN4NESs2YGEhrfaICHYmKiFsOSB
 TnPE3w1y43gtMsYd8QF4aWAAkGHQBv2cbml9Lk5DtA==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.12.22 um 08:40 schrieb Umang Jain:
> Additional declaration of struct vchiq_instance was introduced in the
> commit 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to
> service callbacks"). Drop the extra declaration.
>
> Fixes: 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to service callbacks")
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
