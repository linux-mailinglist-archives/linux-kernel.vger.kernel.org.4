Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC686B1B47
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCIGRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCIGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:17:36 -0500
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A8E183
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678342651;
        bh=X2372syPJ0EjGB7oo1x98LzxP5RImmU2QpNfzgKfS+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AqUvnPOUoplGx3OS+PStU5P3gnkKsJYzeOviczU+zYVnukFRfjO8viOAVpBnhWX2F
         qznsrJ1dRBmViIEvgFF6VfAFJsQNgtNua0cuKyzMlFdF7kdRMBxmXDVc6liUEnSqA9
         wHcgQGlIw0Gp6m5fmAVVEvEYNP8Er58f++Uurrjc=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 45CA1CE8; Thu, 09 Mar 2023 14:17:28 +0800
X-QQ-mid: xmsmtpt1678342648tnck0nryb
Message-ID: <tencent_6C1EB1C28045C83B4BE8B24BC5EC3569B405@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9NpVbIUDPQeHKaCT7vPbx+uR/i3SQwkl5T+fusqTWMwhE9crD5i
         +lIZS5UxjPi5tPv/FPdRK5lnz1Z3iaImojBWOof+lwA3qQXL9mPBe/Ag+4+mApmAsI+OSCyZ0VHn
         4AYupizFvr9Wj/AQ6ruuOpWPn7LbgbhV+wchhDSJrMw0XzZg93qmBXDDbdzWWD5FI2DB+7AtYH7n
         dO8R/m6n2BEtoH7qjync6hNK5YKvUajhX+R2N/PBymjoHLS6ZdWPB1W8UgnLKsVhJVUiRIAodSYo
         r+2uWMtfH3Cr9glW3SUcfmcVuYjGFxzLA7kSP0n6akOe+mS6GwIWmMDJ8yzgtVaDQJi0aVs8olvI
         bHgilqhz6POoI1oX5UUKHdy1Lt1TSrpUTr3ko4KrXgmQtXP8yzCCULamkaxvvvnFEN/1Hu7fA2Ip
         2Rh5E24e390ggaYFs4PmAAzYxwVd1s14v3XJf2+l2JPrHHojb2BC1MXeyzpury60j6uQla8fchqJ
         FQap0Wy8L0VxLdEAJ/+hdOzGVQFC683ggYYY1RsZDwyCHoMNjLT++9DO54HhmiCLT6sRWeQKnLQN
         jx4Rzv87K6azJTZBZ7XDI1Ip5g8T68b1xIbNsTIVah74rqnKXA2SfFR54+6etSV/dc4r/h9NXPgo
         ZmPUH7GbLKYinlKUUDbz/kQADY7tR1U7+HFshrIkm3Y13xERhmEMp5D0QvhZhm0K0u+ViTwdxnS1
         DvBDrj6NBffgkm3Ucbs9AFZ0vcfoMrxNc5Q34FKBg4IFBganSa2orr4fOl2aklkku/If1PPyFAsB
         NlAzjJjtm5dmtHsP0nsD1tGkGK8c5Z/pJeC/Up+4jTKAHPHohXS1s1uixjsYZUnAvoJRsR+10xeE
         8nHeDoHE+XYwat9L1QMUpxBQUGQxoxQzp0aJcxV/aFmCcH16Ygbtjpn6MpOuWc6M8S8no+v72jAP
         GXwUaBkREnq546MCwcm/ipIjbPAReF1MHj6+yAXbxAps6tGSTmOshw1i7SC13liiDVWItGZCnMvB
         JKAxTJ3Ig648bKuYpaFQFRR99NqNA=
From:   Rong Tao <rtoax@foxmail.com>
To:     sgarzare@redhat.com
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        rongtao@cestc.cn, rtoax@foxmail.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] tools/virtio: virtio_test -h,--help should return directly
Date:   Thu,  9 Mar 2023 14:17:28 +0800
X-OQ-MSGID: <20230309061728.30659-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308141737.ioxvifnarhluafmh@sgarzare-redhat>
References: <20230308141737.ioxvifnarhluafmh@sgarzare-redhat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split patch [0] into 3 separate patches [1][2][3].

[0] https://lore.kernel.org/lkml/tencent_A95EA946D511450DBE8486B2122FA1549609@qq.com/
[1] https://lore.kernel.org/lkml/tencent_52B2BC2F47540A5FEB46E710BD0C8485B409@qq.com/
[2] https://lore.kernel.org/lkml/tencent_4B5122C4158323A1D1ACA04B3295F1579207@qq.com/
[3] https://lore.kernel.org/lkml/tencent_89579C514BC4020324A1A4ACA44B5B95BB07@qq.com/

Thanks,
Rong
