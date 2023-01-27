Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2941C67F084
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjA0Viz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjA0Viw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:38:52 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0052B21298
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:38:50 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id l1so2938106qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkjlJx23CrkCdR6Z9AlaV1vvEzLjMrV/VSTIV1fEBgE=;
        b=mdSFmRNUmWQq+PcXXLwJph7CYzqDTSPiartUvARRGxoGc1aVC4POxGBX2FggO/3pu3
         tQFZhD+2V6mS+vdDTGCdjH8/FrQxi8HRqTTNNPcMu5W5wnxcbINbEwC2uNxi16VqiCrO
         spk3LNSUUGWq9NS1/ROkCfB5Ox947kYiSkJhopYy57uEk7X1FazkJABT0QaaWtsjwE7r
         wO/3wn0B/X9ffj10o5BpGlMf6j3OkxuiwccZ79tRyIm09vaB2+BsgheNIk/XNgIon8r0
         AAe5cGFFuaXLmz3cJvk7X0bAKvEdrCkDma6CLHS4KCzXss+wZOUs7zLIkLGlwB9b1ui4
         u6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkjlJx23CrkCdR6Z9AlaV1vvEzLjMrV/VSTIV1fEBgE=;
        b=JSBNro2da99QxYEhnEQ20CM6aO05ehwqPU37L4JSAGWYCESRvv0/QqnjJynCJrwaTw
         2VjBnBn6GncDuMzP2xWsXL+L0hk+8vqyMJ/Ylcvpt/SYyIAQkBLBiHBaVozx7ym+MMJd
         wwr+39saXBErRT0wG3uo1d8wX0dmWYdzAo39mLuHFDQV+KJbC4eeQnNJjdU+pIY3rt4r
         P3HEecYkBBnfuey55avhpgml06p75DnncBlPjq7gUMi0t56xRTsXX4wl7RZoDQsdI/ai
         E+bORtsQKsheEbZNhA6RZkFkllCg9tk9F0PFPUR5Gwv8hreI/Zq/Y7C0dFv0TsTWoQ31
         6JgQ==
X-Gm-Message-State: AFqh2kqnnOK2dv1Y6fULF83ZEfn7s7y4YHAJ9iI9vH7QRX9HYL4+KuJt
        cXu0tj1fbetLQqCjaWKOwWJY68S9yFgdLgfbVEk=
X-Google-Smtp-Source: AMrXdXsk2W296jrqnhgL8kKhRiSFwc9CWIOCXF0g3sGOXBKyQYL5TqE8x1jplv4n4pOuAMZpZqMCweE4nKqi6Xud/Ak=
X-Received: by 2002:ae9:e214:0:b0:708:ee3b:e153 with SMTP id
 c20-20020ae9e214000000b00708ee3be153mr1126380qkc.352.1674855529998; Fri, 27
 Jan 2023 13:38:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:622a:2c6:b0:3b6:4a9d:4c83 with HTTP; Fri, 27 Jan 2023
 13:38:49 -0800 (PST)
Reply-To: mrsmargaret1960r@gmail.com
From:   "Mrs. Margaret Christopher" <alkasimabubakar644@gmail.com>
Date:   Fri, 27 Jan 2023 22:38:49 +0100
Message-ID: <CAC84WCrZJNgrSfmMM24wp7WU8T7ZCPvgPUyXRBgHx++ro78g4w@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:72b listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7056]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alkasimabubakar644[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alkasimabubakar644[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over  a month ago. I am A business woman who is
dealing with Gold Exportation, I Am from USA California i have a
charitable and unfulfilling project that am about to handover to you,
if you are interested to know more about this project please reply me.
 Hope to hear from you

Best Regard
Mrs Margaret
