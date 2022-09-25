Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2336C5E9355
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIYNVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIYNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:21:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5338F2EF3F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 06:20:58 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id cRZ1oksgTtUbycRZ1oDXx4; Sun, 25 Sep 2022 15:20:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Sep 2022 15:20:56 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] headers: Remove some left-over license text in include/uapi/sound/
Date:   Sun, 25 Sep 2022 15:20:46 +0200
Message-Id: <203c1db92c470925f31e361f6e7d180812501f2e.1664112023.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a SPDX-License-Identifier tag, so the corresponding
license text can be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Note: include/uapi/sound/compress_params.h has a slight modification in the
wording.
---
 include/uapi/sound/asequencer.h       | 16 -----------
 include/uapi/sound/asoc.h             |  4 ---
 include/uapi/sound/asound.h           | 16 -----------
 include/uapi/sound/asound_fm.h        | 15 -----------
 include/uapi/sound/compress_offload.h | 17 ------------
 include/uapi/sound/compress_params.h  | 38 ++-------------------------
 include/uapi/sound/emu10k1.h          | 16 -----------
 include/uapi/sound/hdsp.h             | 14 ----------
 include/uapi/sound/hdspm.h            | 15 -----------
 include/uapi/sound/sb16_csp.h         | 15 -----------
 include/uapi/sound/sfnt_info.h        | 15 -----------
 include/uapi/sound/snd_sst_tokens.h   | 10 -------
 include/uapi/sound/tlv.h              | 11 --------
 include/uapi/sound/usb_stream.h       | 14 ----------
 14 files changed, 2 insertions(+), 214 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index a75e14edc957..6d4a2c60808d 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -3,22 +3,6 @@
  *  Main header file for the ALSA sequencer
  *  Copyright (c) 1998-1999 by Frank van de Pol <fvdpol@coil.demon.nl>
  *            (c) 1998-1999 by Jaroslav Kysela <perex@perex.cz>
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 #ifndef _UAPI__SOUND_ASEQUENCER_H
 #define _UAPI__SOUND_ASEQUENCER_H
diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 053949287ce8..9f35bedafcff 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -5,10 +5,6 @@
  * Copyright (C) 2012 Texas Instruments Inc.
  * Copyright (C) 2015 Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Simple file API to load FW that includes mixers, coefficients, DAPM graphs,
  * algorithms, equalisers, DAIs, widgets etc.
 */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 3974a2a911cc..de6810e94abe 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -3,22 +3,6 @@
  *  Advanced Linux Sound Architecture - ALSA - Driver
  *  Copyright (c) 1994-2003 by Jaroslav Kysela <perex@perex.cz>,
  *                             Abramo Bagnara <abramo@alsa-project.org>
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 
 #ifndef _UAPI__SOUND_ASOUND_H
diff --git a/include/uapi/sound/asound_fm.h b/include/uapi/sound/asound_fm.h
index 8471f404ff0b..25ec5e38af5c 100644
--- a/include/uapi/sound/asound_fm.h
+++ b/include/uapi/sound/asound_fm.h
@@ -10,21 +10,6 @@
  *                           4Front Technologies
  *
  *  Direct FM control
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 
 #define SNDRV_DM_FM_MODE_OPL2	0x00
diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 3aef123dbd7f..d185957f3fe0 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -5,23 +5,6 @@
  *  Copyright (C) 2011 Intel Corporation
  *  Authors:	Vinod Koul <vinod.koul@linux.intel.com>
  *		Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
  */
 #ifndef __COMPRESS_OFFLOAD_H
 #define __COMPRESS_OFFLOAD_H
diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 726361716919..ddc77322d571 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -7,47 +7,13 @@
  *  Authors:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
  *              Vinod Koul <vinod.koul@linux.intel.com>
  *
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  * The definitions in this file are derived from the OpenMAX AL version 1.1
- * and OpenMAX IL v 1.1.2 header files which contain the copyright notice below.
+ * and OpenMAX IL v 1.1.2 header files which contain the copyright notice below
+ * and are licensed under the MIT license.
  *
  * Copyright (c) 2007-2010 The Khronos Group Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining
- * a copy of this software and/or associated documentation files (the
- * "Materials "), to deal in the Materials without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sublicense, and/or sell copies of the Materials, and to
- * permit persons to whom the Materials are furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Materials.
- *
- * THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
- * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
- * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
- * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
- * MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
- *
  */
 #ifndef __SND_COMPRESS_PARAMS_H
 #define __SND_COMPRESS_PARAMS_H
diff --git a/include/uapi/sound/emu10k1.h b/include/uapi/sound/emu10k1.h
index 88609cc0524c..1c1f1dd44611 100644
--- a/include/uapi/sound/emu10k1.h
+++ b/include/uapi/sound/emu10k1.h
@@ -3,22 +3,6 @@
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>,
  *		     Creative Labs, Inc.
  *  Definitions for EMU10K1 (SB Live!) chips
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 #ifndef _UAPI__SOUND_EMU10K1_H
 #define _UAPI__SOUND_EMU10K1_H
diff --git a/include/uapi/sound/hdsp.h b/include/uapi/sound/hdsp.h
index b8df62b60f4d..0961954658d6 100644
--- a/include/uapi/sound/hdsp.h
+++ b/include/uapi/sound/hdsp.h
@@ -4,20 +4,6 @@
 
 /*
  *   Copyright (C) 2003 Thomas Charbonnel (thomas@undata.org)
- *    
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifdef __linux__
diff --git a/include/uapi/sound/hdspm.h b/include/uapi/sound/hdspm.h
index 14af3d00ea3f..7043bb3d435a 100644
--- a/include/uapi/sound/hdspm.h
+++ b/include/uapi/sound/hdspm.h
@@ -4,21 +4,6 @@
 /*
  *   Copyright (C) 2003 Winfried Ritsch (IEM)
  *   based on hdsp.h from Thomas Charbonnel (thomas@undata.org)
- *
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifdef __linux__
diff --git a/include/uapi/sound/sb16_csp.h b/include/uapi/sound/sb16_csp.h
index e64851481d88..5a80f5ec02ee 100644
--- a/include/uapi/sound/sb16_csp.h
+++ b/include/uapi/sound/sb16_csp.h
@@ -4,21 +4,6 @@
  *                        Takashi Iwai <tiwai@suse.de>
  *
  *  SB16ASP/AWE32 CSP control
- *
- *   This program is free software; you can redistribute it and/or modify 
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 #ifndef _UAPI__SOUND_SB16_CSP_H
 #define _UAPI__SOUND_SB16_CSP_H
diff --git a/include/uapi/sound/sfnt_info.h b/include/uapi/sound/sfnt_info.h
index c9a810a6ef48..f2b5e13fb5a7 100644
--- a/include/uapi/sound/sfnt_info.h
+++ b/include/uapi/sound/sfnt_info.h
@@ -6,21 +6,6 @@
  *  Patch record compatible with AWE driver on OSS
  *
  *  Copyright (C) 1999-2000 Takashi Iwai
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 
 #include <sound/asound.h>
diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index ff3748e9308a..defeb0c6ed20 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -4,16 +4,6 @@
  *
  * Copyright (C) 2016 Intel Corp
  * Author: Shreyas NC <shreyas.nc@intel.com>
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 #ifndef __SND_SST_TOKENS_H__
 #define __SND_SST_TOKENS_H__
diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
index 7d6d65f60a42..b99a2414b53d 100644
--- a/include/uapi/sound/tlv.h
+++ b/include/uapi/sound/tlv.h
@@ -1,15 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-/*
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- */
 
 #ifndef __UAPI_SOUND_TLV_H
 #define __UAPI_SOUND_TLV_H
diff --git a/include/uapi/sound/usb_stream.h b/include/uapi/sound/usb_stream.h
index ffdd3ea1e31d..50609016185a 100644
--- a/include/uapi/sound/usb_stream.h
+++ b/include/uapi/sound/usb_stream.h
@@ -1,20 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
 /*
  * Copyright (C) 2007, 2008 Karsten Wiese <fzu@wemgehoertderstaat.de>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- * for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifndef _UAPI__SOUND_USB_STREAM_H
-- 
2.34.1

