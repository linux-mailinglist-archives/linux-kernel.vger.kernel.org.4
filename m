Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882BD6D4684
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjDCOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjDCOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:09:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D22952D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:08:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id ga7so28408123qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530903;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvu17jtBzUdVIt48pYfDX8FMfxeLbfuWheO2Syuiucw=;
        b=IN62T8PkQTHafuH2Hmgmu7kYINTpyXxznJDT69Z8iF04tnYEYe96HMiJeUC9bvC+xn
         kStHMs/3jJyuUgE0YCN8S1csorVmyiGBQhOub7ATI2Dw8dE5mhF4QTkXIb+oQ8VO2djx
         t32UJLEN1hNPok0vWOJsFxq1/X8C8dH0CJmYgxC395VAikeW6UWlZNYCWedR37Ay+fr+
         2iFvSHEoyZ+FPn+o6KydFrdxorxRQZ4QgQEDrVYiGGZnCfR0s7Wacr9d5zUJcdgCAIgk
         tO3bypanHh1ByYi3RJlgWXnotBqT/MCxqVegYNU9nWvkS2aQwUq9HsM1mv3xaG0UAh8a
         3h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530903;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvu17jtBzUdVIt48pYfDX8FMfxeLbfuWheO2Syuiucw=;
        b=2F/i13XL/ycDreybZFRE6fWYNITf0bRSpoRqh52I13aNPn5eTEni/kj10zuytZ6L+t
         zf8CRLJk0GoKqANx9wvxZdIg2ZiKrztFLC3ZEeUCnrPCfKNpYkAhxFR08MFO12MhihmU
         I+X1Rzr7Gb8LcS4tODgndtxcmd8q2/zOFUlinmNNnZxgzhai45ApjOF7I4vfLWdVDjOS
         MVNZuAdPOgCP8QG0LGpKr9t6jrXKiiDabUgFnF+zN53D7Gjht8RBb5A31G2gb1mzS1da
         cEFODVyxkwhv5uy+0jVBB8Te5QVsg5QrbvwDBl+5nQiKaRsgABO3Dl3RIFwhJq0QyuRp
         cdtw==
X-Gm-Message-State: AO0yUKUn0JL1aUIJakFjpgfMt0atH0rHDE10szq0L0ygW5tW12FOgc6A
        Iyzwcp4zOxzWPKMLbenqXEsStDQnISQ7PrgQW1s=
X-Google-Smtp-Source: AK7set8C1nYu7CESyTkmVQSPOSTmUbHlUMwk19fcCWrb90uBntK49KvgHuyByq07nDtMsF6SIT3vugCWaV8OMDaa0nM=
X-Received: by 2002:a05:622a:88:b0:3bf:b826:a5e3 with SMTP id
 o8-20020a05622a008800b003bfb826a5e3mr12877423qtw.1.1680530902895; Mon, 03 Apr
 2023 07:08:22 -0700 (PDT)
MIME-Version: 1.0
Sender: msakamoto556@gmail.com
Received: by 2002:ac8:5fcd:0:b0:3dd:1286:e077 with HTTP; Mon, 3 Apr 2023
 07:08:22 -0700 (PDT)
From:   mrs Annie Hyemin kim <mrsanniehyemink@gmail.com>
Date:   Mon, 3 Apr 2023 14:08:22 +0000
X-Google-Sender-Auth: bJLElWDzb3C41_eZTpDPOCxtn4s
Message-ID: <CAMnaCzQ_EJ2bPLb=FJ60-z5Wt1gOndm_R_jMwxkyfNPfQ2vSMw@mail.gmail.com>
Subject: My Greetings , How Are you today,did you receive the email i sent you
 a few days ago please get back to me for more information
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Greetings , How Are you today,did you receive the email i sent you
a few days ago please get back to me for more information
