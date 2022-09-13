Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14235B6EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiIMOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiIMOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:02:37 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4569A52089;
        Tue, 13 Sep 2022 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1663077751;
        bh=O1z3l50xIaYRroOo+hnaK6L/EtOU7idyMtJpMw+/BwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MUu0OO1rfXql6B84I4hTiT5lRNr4t5xfOEY0Ot8sB9wBk24YmRJKnkdCXFMsI/j3F
         ySFEGUvX3jhu6RmJlC50OOOc0ZeBAz+c62SJ2BpMi7DJecBY096TdHDysSX9/bS2qx
         BbwgNXSpOrdbl1rUlhOGHSSJVZGFyJmqNUVZMjbQ=
Received: from localhost.localdomain ([111.199.187.40])
        by newxmesmtplogicsvrsza31.qq.com (NewEsmtp) with SMTP
        id 9B21E83; Tue, 13 Sep 2022 22:02:27 +0800
X-QQ-mid: xmsmtpt1663077747tlwp82smi
Message-ID: <tencent_DE0CDA85E4B2F02FD3547C5E0746E3109909@qq.com>
X-QQ-XMAILINFO: OC704IrkdJt62SQ4r8Yi3WTXGA3h47FQ6UsElMlGE0Rpncl8274I3TBlTvo5Fk
         ldigeJyfqLpJDUjBKg1+wBwhYihnWwPGW5w5zzM8WCaF1324NV59K1LNbEE0OvQ/79x/DV/ft6qK
         1WAwkh3RqwV+qPpuIUrtD0qqC1zUUgD/u9V7jm6qcqvFahjt98gnzuUsT62lVolTs3deURvKGe2L
         NPdR3wALVZPi8GCzTIAiKHqIm1lqyry43hE7wAC4PFKTpWQpCQSKh9bWbFL6AQkWjENjVsSzbsM+
         ZpzwOzHYQICUVhhdRqualixtlWjDZSMGlodOy3gKgzJRmshECAaTZE+tPk6ydPsaLdPw5+fjPM6P
         LF4u0XA16vpwiN0p6UemetVDAAZv8RLtdBO+7xOkQup9h4ICij3b6w7eAiq9qeWdF6NpQSoVfN/n
         uSalOJLomM3zDNvrA7eUKjhgGVHHTWhPgIV6mUNb5Qoy7hTjDtoQq2G0m0w5uR55RPrJGqBOeXDs
         SZiU5veOSJEa/6m1e4QlazWOoTZw76LEfgsw99rXrEuvmDj9EvCFOJmOdE/XqNIllQ6miK+qtOOi
         9JY7HWVCZRkZOsdKt/dkVLiLzLCnqToB4VxW9c+ggGcEYwwuR6x8BEAW4IW/AXrjuVYIUt62kOn1
         38/afvE2i8wRrRp47+wsMyMNthC9/52vYAyQWCKfW08Dlv1iey2ryAvV4fjVLjrBFlhVCntWZLj5
         2Rx40UvsdiT0n9cziT/oUoO4UZgaG9AqTORir+RGupmKnNEE929Trqk7UsMI1H3uDIlQkEQfMQjr
         k2FDL7zc0gY6cfTsZ1hDdZKsn3dCtMkXCu0B7Afr2gLY4j445vMLiKYxyTxQvIhgvUsFrbXPjkE+
         Q89VhQqaJ/D8no7GomiJlL+ef9vyFkwt7LacLUVXJoDnoRTwR8+IbddQIju0tFmG+PFVnJ323qAq
         3hyDT3klcJzuLOdpUZW/WtWqFgdopECGremmixqRy05kFNbEM6EE9gDnLefIy5
From:   Rong Tao <rtoax@foxmail.com>
To:     bagasdotme@gmail.com
Cc:     corbet@lwn.net, erik@kryo.se, jkosina@suse.cz,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@leemhuis.info, lkp@intel.com, ojeda@kernel.org,
        rdunlap@infradead.org, rtoax@foxmail.com, tglx@linutronix.de
Subject: Re: Re: [PATCH] Documentation: process/submitting-patches: misspelling "mesages"
Date:   Tue, 13 Sep 2022 22:02:26 +0800
X-OQ-MSGID: <20220913140226.17692-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <7862b646-9214-3f0c-54d4-6183157f2c2a@gmail.com>
References: <7862b646-9214-3f0c-54d4-6183157f2c2a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for your reply! This is indeed [PATCH v2],
not familiar with the use of send-email before.
