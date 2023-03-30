Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2609D6D011C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjC3K0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjC3K0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:26:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7705272A7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:26:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h11so16903202lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680172006;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PTH+j6/V++4K4Z8NqQR+xHb1s1fBTfyw/reivrtPp7s=;
        b=l/gqP4GKwbc535yMjz0V1QOXEiQi+WaCQ5PTmcfzmYoYusnUf/IZ7v1V2NxpHwn3Wt
         Oyjt0FJ/JftnkJ7mj+soT2iI4nf9r9jSNJB4nJNxPwbluF7wwKF6z+pCFOTjGfcZQWWh
         w63CN5EVDZhxqT2pdqAK4qVRAscLV48GuGmUuAJFzyCBV42xU8zcSK1HPrnL7kGewUW2
         f1iL3Uc6fS0Ykn98/epnxuzKkHHv2GWZS8t5WSv7x3XefKbuIgrrqn9OUwXQaoRqqUPa
         lu0bRZS+YBT/aNhFaxZ2Vsp8E9JlMYu2pid78XEhvA3XvEN5uo1zadr4tLuSl4y2++B5
         eVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680172006;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTH+j6/V++4K4Z8NqQR+xHb1s1fBTfyw/reivrtPp7s=;
        b=dORTOvbGofpXhqXg1pyTIWkzk4VbpHsdjKdzzaJt9VSDJ2JOoXayt2Y+0extszKtew
         5X54A8JwCbKXozIU3nO15ywZsIRRBNlberWT5MGkB+SUk/J/2XhC3NzSAc1Fvqo/Nm20
         JjEap9c8wMzfNbeM/zoMg+XfWNgjER1v7EqxjK4/Vq7huR2HiYMchWYeh/mjG/QoOYL0
         phDPJlAxVcVojWzUyCBObgTWzsVWEojOMD1m04OUT7I1afbFhUMauwSj8mwDBtSjvhW9
         uA6/YEhhvJS9rzndfC/M3lSUj5aazG527ka3eG4BKSHeCz390K8+0nK7KUHbnxNFqyxm
         Hhuw==
X-Gm-Message-State: AAQBX9dHJ3Z4K0hvgePYYZmiv2cv8ehbiXMtx4TnTOZgInlf5fI//G/v
        27P+JDV6AYfLmWLlphDezDpoUCfj06pckDzRtQ==
X-Google-Smtp-Source: AKy350Zk0TmaHMtGbOCxtxyb6qaV1+8/DC6dvWEFKs5Gcs6sKwad6l4wniydXfJ49w/bPAb4grmAkHDnp/V5iVJNyBg=
X-Received: by 2002:a05:6512:ea7:b0:4e8:3ee1:db14 with SMTP id
 bi39-20020a0565120ea700b004e83ee1db14mr2513971lfb.6.1680172005940; Thu, 30
 Mar 2023 03:26:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7655:0:b0:222:4fad:76ea with HTTP; Thu, 30 Mar 2023
 03:26:45 -0700 (PDT)
From:   margreta Zuta1 <mzuta207@gmail.com>
Date:   Thu, 30 Mar 2023 12:26:45 +0200
Message-ID: <CAJcbbv6UiBwVfR54c28hqBZySRpP5ziemWxecdYqpYYGa-iw_Q@mail.gmail.com>
Subject: Royalty Investment Fund
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLY,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Sir/Madam,
I have USD$15 Million royalty fund to be transfer  to you for
investment purposes. I am waiting urgently for your email reply .
Mrs Margret  Zuta .
email  margretzutaer01@mail.com
