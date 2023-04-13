Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C856E0F33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjDMNuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDMNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:50:19 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D5D7280;
        Thu, 13 Apr 2023 06:50:04 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54fbee98814so34788827b3.8;
        Thu, 13 Apr 2023 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681393803; x=1683985803;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=me/aMOzykgZd/rQWir4A2t1w//OGU8Q3sKZmPgaxe3w=;
        b=L6w5otXIHyI2IbOVWI9zFAmYPFxav9f5v27dXrrRH5HzftZ+oIBUdCXz/CXcq12RZK
         /uxMw4zvD1cr7CPBX5VkAuLku7Csi2L9kUR8s5hSavTTtFO6c1Q7p8j/IShwjeXZ3/e0
         /6XxUhegy5rZurXznROgvK/yQI1ndV1AdK+/HTneWQlrgs7Sjz8zhnXeQEKoHid1LHWK
         rej8qf/u8enxGMKgKXMT7VcTCYpfuW/0n1bgRZlGK0ry9fPPE+uO/3WL/VgOspLH/+9P
         oAEBBGoTla0VCEK2cx2VuMcjujESdZ9fRkAgT9v1oIj9FapE0mgylJzG1/fU24vEMChx
         pJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393803; x=1683985803;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=me/aMOzykgZd/rQWir4A2t1w//OGU8Q3sKZmPgaxe3w=;
        b=HRayYSlNRhsbGz2ArQ80AN5DDCLiHlYHnafqZJ2gzJ6SHDeuwgnHyqcvaYzuNnrJUE
         bAlC0F9zCra4IsC4nks4EYtm6AN2OI/kYhX5m7RWsdlwQcZvVjDsY/CctOJTzi4RgUfS
         N9nvHd27wl5neqsc9HpchtYH+dJIrcrLLsh+OZlOj7liap1hlIrn9C0J+ia4qmhgHLd9
         N/Ipn4kfmXYYpcNKcbY6Wnv3MOX3OtDu2vj3Keer9KXL0HU4s7rhSm0hmWb0N5JiJLc9
         DHUvdPJGMAX+QuTz2xJEv0R0UQPwjxoc6fIlJAT4uib2U9bDSd/dYDgtKtZHlrWFR9+B
         pZJg==
X-Gm-Message-State: AAQBX9dhzjwyvUDWGAz1LllY7w8rfxZN1IgOWKbRq2KGWCINbanQUhVW
        m35tGyhYVBaFgSbDgUOtvyu+ynhH+bCNEogP32t/pTAc9ZY=
X-Google-Smtp-Source: AKy350abCiWuKt0W2Oza25xh9u6LUaylRn/CALV3kMLCROgnXylFy50rKXHdCamIScI6llmAjIwhKyqMFPANJjviXOY=
X-Received: by 2002:a81:7613:0:b0:54f:b9f8:70ae with SMTP id
 r19-20020a817613000000b0054fb9f870aemr1470541ywc.7.1681393803597; Thu, 13 Apr
 2023 06:50:03 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Thu, 13 Apr 2023 19:19:52 +0530
Message-ID: <CAHhAz+haVH-4Hgsz0PpTgUSW1pX4XxwxXwEd7nLVb0sFFwQwCg@mail.gmail.com>
Subject: ALSA: arecord : silennce recorded as 0x80
To:     alsa-devel <alsa-devel@alsa-project.org>,
        linux-sound@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recorded the silence on the default audio card by running "arecord
-d 5 test.wav."

Once it exited, I checked the contents by running "hexdump test.wav,"
and I see that silence is recorded as a sequence of 0x80 instead of
0x00.

0000000 4952 4646 0024 8000 4157 4556 6d66 2074
0000010 0010 0000 0001 0001 1f40 0000 1f40 0000
0000020 0001 0008 6164 6174 0000 8000 8080 8080
0000030 8080 8080 8080 8080 8080 8080 8080 8080
0000040 8080 8080 8080 8080 8080 8080 8080 8080
...

What might be the reason for silence being recorded as 0x80 instead of 0x0?


-- 
Thanks,
Sekhar
