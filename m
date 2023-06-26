Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE573E357
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFZPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjFZPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:30:23 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E610CC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:30:22 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b055511b85so167537fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687793421; x=1690385421;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv3Oza0BS8FB5HuKoQsTEZGc12my+ZwhFUt0U/BBpbk=;
        b=FFM3phr9r7YO0sAvzqTlB36kA7XYntr1+k8kfMoWRPFY968/qBy+S9AgMGW4cOJP8i
         TCQRQziC/uBqKJUeQz+fpyJrIw1WYzKd9iJ+gy/mMbGasyze3lI1TmCcIN6lWlkP15OL
         yhufsR3svHwe/PmmqXBzDPRrlsUWSzXunxtoY5UfNWSDKU7laVDlxdBi1TL6joz4N6BY
         J73kpMG9NsgU4iKzZvlI1kWLmvu6iwEiXuOKK9mhZKG0OOQnpF5aHxhS8PhWqMPa3xJk
         gLSRD2P4vW0MUi5xXElJqjk7FWJhmaA3GeA5Ls7Uy/2kG3TMES0scFR91guroRXS3kPp
         ZjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793421; x=1690385421;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tv3Oza0BS8FB5HuKoQsTEZGc12my+ZwhFUt0U/BBpbk=;
        b=TOc9bxAtDvFyrst2Jfzhc0ojpaEXGdGOxer7inpWkVyfK2fWfduewXYHpQvvpILGJS
         otRy+fD+d0dLTJBHngyWdMK0oSt2NK8tb5Cw+ralXU585NSgDLyG2C1+9mr3x6MW7ypT
         S8OZY/2jXOCXsIwNfJKm8DbgL8K1bQk0w1KagTTysl7CC/lfQxOaIIjooZnAOuBHofrT
         rPvLAxGcG/xy6mDsx2KpSWaG3yQech4VbtzE53O32Y4k6mHCMJuH26ZEvHV16h3Ns8Gk
         skXR8Z5/BkmhpCu+DSXlJNDCXWYn8Wd4stlTUeIaGK2Y3nKfxFsHWSQI+F1KsD72gKdu
         wjxA==
X-Gm-Message-State: AC+VfDwUNrujZN1wrOCVhFxOljQ+RJV1XKCG1uNcdR/MhPhpa61PFfR1
        t5wu+NRjDs37LMEZxfNHQ9w=
X-Google-Smtp-Source: ACHHUZ6icc6YbtDNynZSO696+EvC2zRDhVtavE3pUy02282L0oQZmUIKe59RxumGtPdmd7ehpUW85A==
X-Received: by 2002:a05:6870:b302:b0:19e:34f8:4d4f with SMTP id a2-20020a056870b30200b0019e34f84d4fmr23973673oao.32.1687793421198;
        Mon, 26 Jun 2023 08:30:21 -0700 (PDT)
Received: from [183.173.18.2] ([183.173.18.2])
        by smtp.gmail.com with ESMTPSA id r25-20020a6560d9000000b00513cc8c9597sm3766544pgv.10.2023.06.26.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:30:20 -0700 (PDT)
Message-ID: <496af9e1-4a25-e68a-da80-ec11126b6dc2@gmail.com>
Date:   Mon, 26 Jun 2023 23:30:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Tuo Li <islituo@gmail.com>
Subject: [BUG] firmware: imx: possible null-pointer dereferences and
 data-inconsistency due to data races in imx_scu_rx_callback()
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        alexander.stein@ew.tq-group.com, quic_mojha@quicinc.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        baijiaju1990@outlook.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Our static analysis tool finds some possible data races in the IMX
firmware in Linux 6.4.0.

In the function imx_scu_call_rpc(), the variable sc_ipc->msg is
accessed with holding the lock sc_ipc->lock:

   imx_scu_call_rpc()  --> Line 203
     mutex_lock(&sc_ipc->lock);  --> Line 212 (Lock sc_ipc->lock)
     sc_ipc->msg = msg;  --> Line 216 (Access sc_ipc->msg)
     sc_ipc->msg = NULL;  --> Line 251 (Access sc_ipc->msg)

However, in the function imx_scu_rx_callback(), the variable
sc_ipc->msg is accessed without holding the lock sc_ipc->lock:

   imx_scu_rx_callback()  --> Line 112
     sc_ipc->msg[0] = *data++;  --> Line 129 (Access sc_ipc->msg)
     sc_ipc->msg[sc_chan->idx] = *data;  --> Line 148 (Access sc_ipc->msg)

I am not sure whether the functions imx_scu_call_rpc() and
imx_scu_rx_callback() can be executed concurrently and whether
the variables sc_ipc in the two functions can be the same. If so,
harmful data races can occur because:
1. If the variable sc_ipc->msg is set to NULL after the if check at
Line 120, null-pointer dereferences may occur at Lines 129 and 148;
2. If sc_ipc->msg is changed by imx_scu_call_rpc() when updating
sc_ipc->msg with data. The values in data can be written to different
msgs and cause data-inconsistency.

I am not quite sure whether these possible data races are real and
how to fix them if they are real.

Any feedback would be appreciated, thanks!

Reported-by: BassCheck <bass@buaa.edu.cn>

Best wishes,
Tuo Li
